/// FriendListItem displays individual friend entries with their status
/// and quick action buttons.
/// Features:
/// - Displays friend's avatar and name
/// - Shows online status
/// - (Not done) Actions for messaging and location sharing
library;

import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/profile_avatar.dart';

class FriendListItem extends StatelessWidget {
  /// Friend data to display
  final Friend friend;

  /// Callback when message button is tapped
  final VoidCallback onMessage;

  /// Callback when locate button is tapped
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        // Use ProfileAvatar widget for consistent avatar display
        leading: ProfileAvatar(
          imageUrl: friend.avatarUrl,
          isOnline: friend.isOnline,
        ),
        title: Text(
          friend.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // Status text with appropriate color
        subtitle: Text(
          friend.isOnline ? 'Online' : 'Offline',
          style: TextStyle(color: friend.isOnline ? Colors.green : Colors.grey),
        ),
        // Quick action buttons
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
