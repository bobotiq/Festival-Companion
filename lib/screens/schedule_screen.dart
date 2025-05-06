import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<Map<String, String>> events = [
    {"time": "12:00", "title": "Opening Ceremony", "stage": "Main Stage"},
    {"time": "13:30", "title": "Rock Band", "stage": "Stage A"},
    {"time": "15:00", "title": "DJ Set", "stage": "Dance Tent"},
    {"time": "16:30", "title": "Food Tasting", "stage": "Food Court"},
    {"time": "18:00", "title": "Headliner", "stage": "Main Stage"},
  ];

  Set<String> favoriteEvents = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteEvents = prefs.getStringList('favoriteEvents')?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteEvents.contains(title)) {
        favoriteEvents.remove(title);
      } else {
        favoriteEvents.add(title);
      }
      prefs.setStringList('favoriteEvents', favoriteEvents.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events scheduled.',
          style: theme.textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isFavorite = favoriteEvents.contains(event["title"]);
        return Card(
          key: ValueKey(event["title"]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                event["time"] ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              event["title"] ?? '',
              style: theme.textTheme.titleLarge,
            ),
            subtitle: Text(
              '${event["time"]} - ${event["stage"]}',
              style: theme.textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isFavorite ? theme.colorScheme.secondary : Colors.grey,
              ),
              onPressed: () => _toggleFavorite(event["title"]!),
              tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Details for "${event["title"]}" coming soon!'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
