import 'package:flutter/material.dart';
import '../widgets/profile_avatar.dart';

class FriendsScreen extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {"name": "Alex", "avatar": "https://randomuser.me/api/portraits/men/32.jpg"},
    {"name": "Samira", "avatar": "https://randomuser.me/api/portraits/women/44.jpg"},
    {"name": "Jasper", "avatar": "https://randomuser.me/api/portraits/men/54.jpg"},
    {"name": "Lotte", "avatar": "https://randomuser.me/api/portraits/women/65.jpg"},
    {"name": "Chen", "avatar": "https://randomuser.me/api/portraits/men/76.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      itemCount: friends.length,
      itemBuilder: (context, idx) {
        final friend = friends[idx];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: ProfileAvatar(imageUrl: friend["avatar"]!),
            title: Text(friend["name"]!, style: theme.textTheme.titleLarge),
            subtitle: Text("At the festival", style: theme.textTheme.bodyMedium),
            trailing: Icon(Icons.location_on_rounded, color: theme.colorScheme.secondary),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Location sharing for ${friend["name"]} coming soon!')),
              );
            },
          ),
        );
      },
    );
  }
}
