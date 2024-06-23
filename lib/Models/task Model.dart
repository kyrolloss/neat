
import 'dart:io';

class  Tasks {
  final String name;
  final String id;
  final String senderId;
  final String senderEmail;
  final String senderName;
  final String senderPhoneNumber;
  final String receiverId;
  final String description;
  final String date;
  String status = 'todo';
  final String priority;
  final int year;
  final int month;
  final int day;
  final int? dayCompleted;
  final int? monthCompleted;
  final int? yearCompleted;
  final String? image;

  Tasks({
    required this.name,
    required this.id,
    required this.senderId,
    required this.senderEmail,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.receiverId,
    required this.description,
    required this.date,
    required this.day,
    required this.status,
    required this.priority,
    required this.year,
    required this.month,
    this.dayCompleted,
    this.monthCompleted,
    this.yearCompleted,
    this.image,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      name: json['name'],
      id: json['id'],
      senderId: json['senderId'],
      senderEmail: json['senderEmail'],
      senderName: json['senderName'],
      senderPhoneNumber: json['senderPhoneNumber'],
      receiverId: json['receiverId'],
      description: json['description'],
      date: json['date'],
      status: json['status'],
      priority: json['priority'],
      year: json['year'],
      month: json['month'],
      day: json['day'],
      image: json['image'],
      dayCompleted: json['dayCompleted'],
      monthCompleted: json['monthCompleted'],
      yearCompleted: json['yearCompleted'],
    );
  }

  Map<String, dynamic> task() {
    return {
      'name': name,
      'id': id,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'senderPhoneNumber': senderPhoneNumber,
      'receiverId': receiverId,
      'description': description,
      'date': date,
      'status': status,
      'priority': priority,
      'year': year,
      'month': month,
      'day': day,
      'dayCompleted': dayCompleted,
      'monthCompleted': monthCompleted,
      'yearCompleted': yearCompleted,
      'image': image,
    };
  }
}
