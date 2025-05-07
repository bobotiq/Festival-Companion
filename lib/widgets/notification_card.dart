import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onDismiss;
  final VoidCallback onTap;
  final VoidCallback onToggleRead;

  const NotificationCard({
    required this.notification,
    required this.onDismiss,
    required this.onTap,
    required this.onToggleRead,
    super.key,
  });

  Color _getNotificationColor(BuildContext context) {
    switch (notification.type) {
      case NotificationType.eventReminder:
        return Theme.of(context).colorScheme.primary;
      case NotificationType.friendActivity:
        return Theme.of(context).colorScheme.secondary;
      case NotificationType.system:
        return Theme.of(context).colorScheme.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(
        color: Colors.red.withOpacity(0.8),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      child: Card(
        elevation: notification.isRead ? 1 : 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              border:
                  notification.isRead
                      ? null
                      : Border(
                        left: BorderSide(
                          color: _getNotificationColor(context),
                          width: 4,
                        ),
                      ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: _getNotificationColor(
                  context,
                ).withOpacity(0.1),
                child: Icon(
                  _getNotificationIcon(),
                  color: _getNotificationColor(context),
                ),
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight:
                      notification.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  notification.isRead
                      ? Icons.mark_email_unread_outlined
                      : Icons.mark_email_read_outlined,
                ),
                onPressed: onToggleRead,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.eventReminder:
        return Icons.event;
      case NotificationType.friendActivity:
        return Icons.people;
      case NotificationType.system:
        return Icons.info;
    }
  }
}
