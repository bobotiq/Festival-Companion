import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/friend_list_item.dart';

class FriendsScreen extends StatelessWidget {
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
    final List<Friend> friends =
        data.map((map) => Friend.fromJson(map)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, friends),
          ),
        ],
      ),
      body:
          friends.isEmpty
              ? Center(
                child: Text(
                  'No friends found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return FriendListItem(
                    friend: friends[index],
                    onMessage: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Messaging ${friends[index].name}...'),
                        ),
                      );
                    },
                    onLocate: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Locating ${friends[index].name}...'),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }

  void _showSearch(BuildContext context, List<Friend> friends) {
    showSearch(context: context, delegate: _FriendSearchDelegate(friends));
  }
}

class _FriendSearchDelegate extends SearchDelegate<Friend?> {
  final List<Friend> friends;

  _FriendSearchDelegate(this.friends);

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildResults(BuildContext context) {
    final results =
        friends
            .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return results.isEmpty
        ? Center(
          child: Text(
            'No friends found',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
        : _buildMatchingList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatchingList(context);

  Widget _buildMatchingList(BuildContext context) {
    final results =
        friends
            .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder:
          (_, index) => FriendListItem(
            friend: results[index],
            onMessage: () {
              close(context, results[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Messaging ${results[index].name}...')),
              );
            },
            onLocate: () {
              close(context, results[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Locating ${results[index].name}...')),
              );
            },
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );
}
