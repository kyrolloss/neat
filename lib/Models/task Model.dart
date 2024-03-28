class Tasks {
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
  final String year;
  final String month;
  final String day;

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
    required this.status,
    required this.priority,
    required this.year,
    required this.month,
    required this.day,
  });

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
    };
  }
}
