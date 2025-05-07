/// FriendsScreen manages the social aspect of the festival app.
/// Features:
/// - Displays a list of user's friends with online status
/// - TODO: Enables messaging and location sharing
/// - Search functionality to find specific friends
library;

import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../widgets/friend_list_item.dart';

class FriendsScreen extends StatelessWidget {
  /// Demo friend data
  /// TODO: Use a different data source for avatars
  final List<Map<String, dynamic>> data = [
    {
      'id': '1',
      'name': 'Alex Johnson',
      'avatarUrl': 'https://i.pravatar.cc/150?img=1',
      'isOnline': true,
    },
    {
      'id': '2',
      'name': 'Jamie Smith',
      'avatarUrl': 'https://i.pravatar.cc/150?img=2',
      'isOnline': false,
    },
    {
      'id': '3',
      'name': 'Taylor Wilson',
      'avatarUrl': 'https://i.pravatar.cc/150?img=3',
      'isOnline': true,
    },
  ];

  FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Convert raw data to Friend objects
    final List<Friend> friends =
        data.map((map) => Friend.fromJson(map)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          // Search button to find friends
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, friends),
          ),
        ],
      ),
      body:
          friends.isEmpty
              // Empty state when no friends are found
              ? Center(
                child: Text(
                  'No friends found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
              // List of friends with interactive items
              : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return FriendListItem(
                    friend: friends[index],
                    // (MESSAGE) Handle SnackBar message on message button tap
                    onMessage: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Messaging ${friends[index].name}...'),
                        ),
                      );
                    },
                    // (LOCATION SHARING) Handle SnackBar message on locate button tap
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
      // Add friend button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add friend feature coming soon')),
          );
        },
      ),
    );
  }

  /// Shows search interface for finding friends
  void _showSearch(BuildContext context, List<Friend> friends) {
    showSearch(context: context, delegate: _FriendSearchDelegate(friends));
  }
}

/// Search delegate for finding friends by name
class _FriendSearchDelegate extends SearchDelegate<Friend?> {
  final List<Friend> friends;

  _FriendSearchDelegate(this.friends);

  @override
  List<Widget> buildActions(BuildContext context) => [
    // Clear search text button
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results =
        friends
            .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return results.isEmpty
        // Empty state for no search results
        ? Center(
          child: Text(
            'No friends found',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
        // Display matching friends
        : _buildMatchingList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatchingList(context);

  /// Builds list of friends matching search query
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
            // Handle messaging from search results
            onMessage: () {
              close(context, results[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Messaging ${results[index].name}...')),
              );
            },
            // Handle locating from search results
            onLocate: () {
              close(context, results[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Locating ${results[index].name}...')),
              );
            },
          ),
    );
  }
}
