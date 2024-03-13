class Task {
  final String name;
  final String id;
  final String senderId;
  final String senderEmail;
  final String senderName;
  final String senderPhoneNumber;
  final String receiverId;
  final String receiverName;
  final String receiverEmail;
  final String receiverPhoneNumber;
  final String description;
  final String date;
  final String deadline;
  String status = 'todo';
  final String priority;

  Task({
    required this.name,
    required this.id,
    required this.senderId,
    required this.senderEmail,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.receiverId,
    required this.receiverName,
    required this.receiverEmail,
    required this.receiverPhoneNumber,
    required this.description,
    required this.date,
    required this.deadline,
    required this.status,
    required this.priority,
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
      'receiverName': receiverName,
      'receiverEmail': receiverEmail,
      'receiverPhoneNumber': receiverPhoneNumber,
      'description': description,
      'date': date,
      'deadline': deadline,
      'status': status,
    };
  }
}
