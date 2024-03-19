class NotificationModel {
  final String notificationId;
  final String messageContent;
  final String title;

  NotificationModel(this.title, {required this.notificationId, required this.messageContent});
}