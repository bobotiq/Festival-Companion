import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/profile_avatar.dart';

class FriendListItem extends StatelessWidget {
  final Friend friend;
  final VoidCallback onMessage;
  final VoidCallback onLocate;

  const FriendListItem({
    required this.friend,
    required this.onMessage,
    required this.onLocate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: ProfileAvatar(
          imageUrl: friend.avatarUrl,
          isOnline: friend.isOnline,
        ),
        title: Text(
          friend.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          friend.isOnline ? 'Online' : 'Offline',
          style: TextStyle(color: friend.isOnline ? Colors.green : Colors.grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: onMessage,
              tooltip: 'Message',
            ),
            IconButton(
              icon: const Icon(Icons.location_on_outlined),
              onPressed: onLocate,
              tooltip: 'Locate',
            ),
          ],
        ),
      ),
    );
  }
}
