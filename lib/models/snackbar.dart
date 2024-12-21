import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarModel {
  String title;
  String? message;
  Duration duration;
  Duration? animationDuration;
  Color backgroundColor;
  SnackPosition snackPosition;
  double? borderRadius;
  EdgeInsets? margin;

  SnackbarModel({
    required this.title,
    this.message,
    required this.duration,
    this.animationDuration,
    required this.backgroundColor,
    required this.snackPosition,
    this.borderRadius,
    this.margin,
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

  factory SnackbarModel.somethingWentWrong() {
    return SnackbarModel(
      title: "Something went wrong!",
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
    );
  }

  factory SnackbarModel.copiedToClipboard() {
    return SnackbarModel(
      title: "Copied to clipboard!",
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: const Color(0xFF303030),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 0.0,
      margin: const EdgeInsets.all(0),
    );
  }
}
