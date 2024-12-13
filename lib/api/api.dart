import 'package:capp_flutter/api/openai_api.dart';
import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class Api {
  static Api instance = Api();

  final CollectionReference userCollection = db.collection("users");
  final CollectionReference chatsCollection = db.collection("chats");

  // Creates a new user in the database if it doesn't exist
  // Returns the user
  Future<User> getUser({
    required String deviceId,
  }) async {
    // Check if the user exists
    final DocumentSnapshot userDoc = await userCollection.doc(deviceId).get();
    if (userDoc.exists) {
      LoggerHelper.logInfo("Api.getUser", "User ($deviceId) found");
      return User.fromJson(userDoc.data()! as Map<String, dynamic>);
    } else {
      // Create a new user
      User user = User.fromValues(deviceId: deviceId);
      LoggerHelper.logInfo("Api.getUser", "User ($deviceId) created");
      await userCollection.doc(deviceId).set(user.toJson());
      return user;
    }
  }

  // Updates the user in the database with the given user
  // if useGivenUpdatedAt is false, the updatedAt field will be set to the current time
  Future<void> updateUser({
    required User user,
  }) async {
    user.updatedAt = DateTime.now().millisecondsSinceEpoch;
    await userCollection.doc(user.deviceId).update(user.toJson());
  }

  // Creates a new chat in the user's chats collection
  // Increments user's totalChats
  // Returns the empty chat
  Future<Chat> createChat({
    required String deviceId,
  }) async {
    User user = await getUser(deviceId: deviceId);

    final DocumentReference chatDoc = chatsCollection.doc();

    Chat chat = Chat.fromValues(
      id: chatDoc.id,
      deviceId: deviceId,
    );

    await chatDoc.set(chat.toJson());
    LoggerHelper.logInfo("Api.createChat", "Chat (${chat.id}) created");

    user.totalChats++;
    await updateUser(user: user);
    LoggerHelper.logInfo(
        "Api.createChat", "User (${user.deviceId}) totalChats incremented");

    return chat;
  }

  // Updates the chat in the database with the given chat
  // if useGivenUpdatedAt is false, the updatedAt field will be set to the current time
  Future<void> updateChat({
    required Chat chat,
  }) async {
    try {
      await chatsCollection.doc(chat.id).update(chat.toJson());
    } catch (e) {
      await chatsCollection
          .doc(chat.id)
          .update(chat.toJson(withoutImage: true));
    }
  }

  Future<Chat?> getChat({
    required String id,
  }) async {
    final DocumentSnapshot chatDoc = await chatsCollection.doc(id).get();
    if (chatDoc.exists) {
      LoggerHelper.logInfo("Api.getChat", "Chat ($id) found");
      return Chat.fromJson(chatDoc.data()! as Map<String, dynamic>);
    } else {
      LoggerHelper.logInfo("Api.getChat", "Chat ($id) not found");
      return null;
    }
  }

  Future<Chat> sendMessage({
    required User user,
    required Chat chat,
    required Message message,
  }) async {
    chat.messages.add(message);
    chat.status = ChatStatus.waiting;

    await updateChat(chat: chat);

    LoggerHelper.logInfo("Api.sendMessage",
        "Message (${message.id}) added to chat in chat (${chat.id}) in DB");

    Future<Map<String, dynamic>> response = OpenaiApi.instance.sendMessage(
      chat: chat,
    );
    chat.status = ChatStatus.processing;
    LoggerHelper.logInfo("Api.sendMessage",
        "Message (${message.id}) in chat (${chat.id}) sent to OpenAI");

    var r = await response;
    LoggerHelper.logInfo("Api.sendMessage",
        "Message (${message.id}) in chat (${chat.id}) arrived from OpeAI");

    int usedInputTokens = r["usage"]?["prompt_tokens"] ?? 0;
    int usedOutputTokens = r["usage"]?["completion_tokens"] ?? 0;
    chat.totalInputTokens += usedInputTokens;
    chat.totalOutputTokens += usedOutputTokens;

    if (r.containsKey("choices")) {
      chat.messages.add(Message.fromValues(
        type: MessageType.ai,
        content: r["choices"][0]["message"]["content"],
      ));
      chat.status = ChatStatus.completed;
    } else {
      chat.messages.add(Message.fromValues(
        type: MessageType.ai,
        content: "Sorry, I couldn't understand that",
      )); // TODO: add more error messages
      chat.status = ChatStatus.failed;
    }

    await updateChat(chat: chat);

    return chat;
  }

  Future<List<Chat>> getUserChats({required String deviceId}) async {
    List<Chat> res = [];

    print("EGE 1");
    try {
      var query = await chatsCollection
          .where("deviceId", isEqualTo: deviceId)
          .where("status", isNotEqualTo: ChatStatus.deleted.name)
          .orderBy("updatedAt", descending: true)
          .get();
      for (QueryDocumentSnapshot doc in query.docs) {
        try {
          res.add(
            Chat.fromJson(doc.data() as Map<String, dynamic>),
          );
        } catch (e) {
          LoggerHelper.logError("Api.getUserChats.forLoop", e.toString());
        }
      }
    } catch (e) {
      LoggerHelper.logError("Api.getUserChats", e.toString());
    }

    print("EGE res ${res.length}");
    return res;
  }
}
