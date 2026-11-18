import 'package:flutter/material.dart';

class NotificationModel {
  NotificationModel({required this.title,
    required this.message, required this.createdAt, this.isUnread = true,
  });

  final String title;
  final String message;
  final DateTime createdAt;
  bool isUnread;

  // to get the value from map
  factory NotificationModel.fromMap(Map<String, dynamic> map){
    return NotificationModel(
      title: map["title"],
      message: map["message"],
      createdAt: map["createdAt"],
      isUnread: map["isUnread"]
    );
  }
}