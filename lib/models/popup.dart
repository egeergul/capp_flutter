import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Popup {
  Widget? icon;
  String? title;
  String? description;
  String? confirmLabel;
  String? rejectLabel;

  Popup({
    this.icon,
    this.title,
    this.description,
    this.confirmLabel,
    this.rejectLabel,
  });

  factory Popup.deleteChat() {
    return Popup(
      icon: CustomIconButton(onTap: () {}, iconData: Icons.delete),
      title: "Do you want to delete this chat?",
      description: "Once a conversation is deleted, in cannot be reverted",
      confirmLabel: "Delete",
      rejectLabel: "Cancel",
    );
  }
}
