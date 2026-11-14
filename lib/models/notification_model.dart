import 'package:flutter/material.dart';

class NotificationModel {
  NotificationModel({required this.icon, required this.iconColor, required this.title,
    required this.message, required this.createdAt, this.isUnread = true,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final DateTime createdAt;
  bool isUnread;

  // to get the value from map
  factory NotificationModel.fromMap(Map<String, dynamic> map){
    return NotificationModel(
      icon: map["icon"],
      iconColor: map["iconColor"],
      title: map["title"],
      message: map["message"],
      createdAt: map["createdAt"],
      isUnread: map["isUnread"]
    );
  }
}