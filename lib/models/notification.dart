enum NotificationType { eventReminder, friendActivity, system }

class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  bool isRead;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    this.isRead = false,
  });
}
