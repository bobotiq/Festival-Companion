import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<AppNotification> _notifications = [
    AppNotification(
      id: '1',
      type: NotificationType.eventReminder,
      title: 'Main Stage starts in 30 minutes',
      isRead: false,
    ),
    AppNotification(
      id: '2',
      type: NotificationType.friendActivity,
      title: 'Alex is now at the Food Court',
      isRead: false,
    ),
    AppNotification(
      id: '3',
      type: NotificationType.system,
      title: 'Welcome to the festival!',
      isRead: true,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _dismissNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            tooltip: "Mark all as read",
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(child: Text('No notifications'))
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) => _NotificationItem(
                notification: _notifications[index],
                onDismiss: () => _dismissNotification(index),
              ),
            ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onDismiss;

  const _NotificationItem({
    required this.notification,
    required this.onDismiss,
  });

  Icon _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.friendActivity:
        return const Icon(Icons.people, color: Colors.blue);
      case NotificationType.eventReminder:
        return const Icon(Icons.event, color: Colors.orange);
      case NotificationType.system:
        return const Icon(Icons.info, color: Colors.grey);
    }
    // No default needed; all enum cases are covered.
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(color: Colors.red),
      onDismissed: (_) => onDismiss(),
      child: ListTile(
        leading: _getNotificationIcon(),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        trailing: notification.isRead
            ? null
            : Icon(Icons.circle, color: Theme.of(context).colorScheme.secondary, size: 12),
      ),
    );
  }
}
