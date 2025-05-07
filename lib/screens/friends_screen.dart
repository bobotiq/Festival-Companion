import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/profile_avatar.dart';

class FriendsScreen extends StatelessWidget {
  // Example data as List<Map<String, String>>
  final List<Map<String, String>> data = [
    {
      'id': '1',
      'name': 'Alex',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
      'isOnline': 'true',
    },
    {
      'id': '2',
      'name': 'Sam',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
      'isOnline': 'false',
    },
    {
      'id': '3',
      'name': 'Taylor',
      'avatarUrl': 'https://randomuser.me/api/portraits/women/3.jpg',
      'isOnline': 'true',
    },
  ];

  FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Convert the data to List<Friend>
    final List<Friend> friends = data.map((map) => Friend.fromJson(map)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, friends),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: friends.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) => _FriendListItem(friend: friends[index]),
      ),
    );
  }

  void _showSearch(BuildContext context, List<Friend> friends) {
    showSearch(
      context: context,
      delegate: _FriendSearchDelegate(friends),
    );
  }
}

class _FriendListItem extends StatelessWidget {
  final Friend friend;

  const _FriendListItem({required this.friend});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatar(
        imageUrl: friend.avatarUrl,
        isOnline: friend.isOnline,
      ),
      title: Text(friend.name),
      trailing: IconButton(
        icon: const Icon(Icons.location_on),
        onPressed: () => _showFriendLocation(context),
      ),
    );
  }

  void _showFriendLocation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location sharing coming soon for ${friend.name}!')),
    );
  }
}

class _FriendSearchDelegate extends SearchDelegate<Friend?> {
  final List<Friend> friends;

  _FriendSearchDelegate(this.friends);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => _buildMatchingList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatchingList(context);

  Widget _buildMatchingList(BuildContext context) {
    final results = friends
        .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) => ListTile(
        leading: ProfileAvatar(imageUrl: results[index].avatarUrl),
        title: Text(results[index].name),
        onTap: () => close(context, results[index]),
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );
}
