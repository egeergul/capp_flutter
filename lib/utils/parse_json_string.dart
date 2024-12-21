import 'dart:convert';

bool isJsonString(String str) {
  try {
    final json = jsonDecode(str);
    return json is Map || json is List; // JSON can either be a Map or a List
  } catch (e) {
    return false; // Not a valid JSON string
  }
}

dynamic parseJsonString(String str) {
  if (isJsonString(str)) {
    return jsonDecode(str); // Parse the JSON string into a Map or List
  } else {
    throw const FormatException('The provided string is not a valid JSON.');
  }
}
