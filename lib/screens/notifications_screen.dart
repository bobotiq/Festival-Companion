import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {"icon": "favorite", "msg": "Samira liked your post."},
    {"icon": "comment", "msg": "Jasper commented: Awesome!"},
    {"icon": "follow", "msg": "Lotte started following you."},
    {"icon": "event", "msg": "Main Stage event starts soon!"},
  ];

  IconData _iconFor(String name) {
    switch (name) {
      case "favorite":
        return Icons.favorite_rounded;
      case "comment":
        return Icons.comment_rounded;
      case "follow":
        return Icons.person_add_rounded;
      case "event":
      default:
        return Icons.event_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      itemCount: notifications.length,
      itemBuilder: (context, idx) {
        final n = notifications[idx];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withAlpha(38),
              child: Icon(_iconFor(n["icon"]!), color: theme.colorScheme.primary),
            ),
            title: Text(n["msg"]!, style: theme.textTheme.bodyLarge),
          ),
        );
      },
    );
  }
}
