import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarModel {
  String title;
  String? message;
  Duration duration;
  Color backgroundColor;
  SnackPosition snackPosition;

  SnackbarModel({
    required this.title,
    this.message,
    required this.duration,
    required this.backgroundColor,
    required this.snackPosition,
  });

  factory SnackbarModel.maximumChatsReached() {
    return SnackbarModel(
      title: "Maximum number of chats reached",
      message: "You cannot add more chats. Delete previous chats to add more.",
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
    );
  }
}
