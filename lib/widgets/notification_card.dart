/// NotificationCard displays individual notifications with customizable appearance
/// based on notification type and read status.
/// Features:
/// - Different colors and icons for different notification types
/// - Swipe-to-dismiss functionality
/// - Read/unread status indication
/// - Interactive read toggle
/// - Tap handling for navigation
library;

import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationCard extends StatelessWidget {
  /// The notification data to display
  final AppNotification notification;

  /// Callback when notification is dismissed
  final VoidCallback onDismiss;

  /// Callback when notification is tapped
  final VoidCallback onTap;

  /// Callback to toggle read/unread status
  final VoidCallback onToggleRead;

  const NotificationCard({
    required this.notification,
    required this.onDismiss,
    required this.onTap,
    required this.onToggleRead,
    super.key,
  });

  /// Returns appropriate color based on notification type
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

  /// Returns appropriate icon based on notification type
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

  @override
  Widget build(BuildContext context) {
    // Dismissible wrapper for swipe-to-delete functionality
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
        // Different elevation based on read status
        elevation: notification.isRead ? 1 : 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            // Colored border for unread notifications
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
              // Themed icon based on notification type
              leading: CircleAvatar(
                backgroundColor: _getNotificationColor(
                  context,
                ).withOpacity(0.1),
                child: Icon(
                  _getNotificationIcon(),
                  color: _getNotificationColor(context),
                ),
              ),
              // Title with different weight based on read status
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight:
                      notification.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              // Toggle read status button
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
}
