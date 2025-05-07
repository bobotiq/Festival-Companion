/// NotificationsScreen displays and manages user notifications.
/// Features:
/// - Shows different types of notifications (events, friend activity, system)
/// - Allows marking notifications as read/unread
/// - Enables dismissing notifications
/// - Handles navigation to relevant app sections from notifications
/// - Visual differentiation between read and unread notifications
library;

import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  /// List of user notifications
  /// These should be fetched from a notification service
  final List<AppNotification> _notifications = [
    AppNotification(
      id: '1',
      type: NotificationType.eventReminder,
      title: 'Headliner performing in 30 minutes',
      isRead: false,
    ),
    AppNotification(
      id: '2',
      type: NotificationType.friendActivity,
      title: 'Alex is now at Main Stage',
      isRead: true,
    ),
    AppNotification(
      id: '3',
      type: NotificationType.system,
      title: 'Weather alert: Light rain expected',
      isRead: false,
    ),
  ];

  /// Marks all notifications as read
  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  /// Removes a notification at the specified index
  void _dismissNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  /// Toggles read/unread status of a notification
  void _toggleNotificationRead(AppNotification notification) {
    setState(() {
      notification.isRead = !notification.isRead;
    });
  }

  /// Handles navigation when a notification is tapped
  void _handleNotificationTap(AppNotification notification) {
    // Navigate to appropriate screen based on notification type
    switch (notification.type) {
      case NotificationType.eventReminder:
        Navigator.pushNamed(context, '/schedule');
        break;
      case NotificationType.friendActivity:
        Navigator.pushNamed(context, '/friends');
        break;
      case NotificationType.system:
        // Handle system notifications (no specific navigation)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Count of unread notifications for the app bar
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications ($unreadCount)'),
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.mark_email_read),
              tooltip: "Mark all as read",
              onPressed: _markAllAsRead,
            ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child:
            _notifications.isEmpty
                // Empty state
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
                // List of notifications
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return NotificationCard(
                      notification: notification,
                      onDismiss: () => _dismissNotification(index),
                      onTap: () => _handleNotificationTap(notification),
                      onToggleRead: () => _toggleNotificationRead(notification),
                    );
                  },
                ),
      ),
    );
  }
}
