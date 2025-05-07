import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

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
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = Event(
            id: index.toString(),
            title: events[index]["title"] ?? "",
            stage: events[index]["stage"] ?? "",
            startTime: DateTime.now(), // Replace with actual time
            endTime: DateTime.now().add(
              Duration(hours: 2),
            ), // Replace with actual time
          );

          return EventCard(
            event: event,
            onFavorite: () => _toggleFavorite(event.title),
            onTap: () {
              // Handle event tap
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: ${event.title}')),
              );
            },
          );
        },
      ),
    );
  }
}
