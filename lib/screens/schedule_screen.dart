/// Schedule screen displays the festival's event lineup and manages user's favorite events.
/// Features:
/// - Lists all festival events in chronological order
/// - Allows users to favorite/unfavorite events
/// - Persists favorites using SharedPreferences
/// - Displays event details including time, title, and stage location
library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

/// Main schedule screen widget that maintains favorite events state
class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  /// Sample event data structure
  /// Format: time, title, and stage location for each event
  final List<Map<String, String>> events = [
    {"time": "12:00", "title": "Opening Ceremony", "stage": "Main Stage"},
    {"time": "13:30", "title": "Rock Band", "stage": "Stage A"},
    {"time": "15:00", "title": "DJ Set", "stage": "Dance Tent"},
    {"time": "16:30", "title": "Food Tasting", "stage": "Food Court"},
    {"time": "18:00", "title": "Headliner", "stage": "Main Stage"},
  ];

  /// Store favorite events in a Set
  /// Uses event titles as unique identifiers
  Set<String> favoriteEvents = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Initialize favorites from storage
  }

  /// Retrieves saved favorite events from persistent storage
  /// Uses SharedPreferences to maintain state between app sessions
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Convert stored list to Set, or empty Set if no data exists
      favoriteEvents = prefs.getStringList('favoriteEvents')?.toSet() ?? {};
    });
  }

  /// Handles toggling favorite status of an event
  /// Updates both local state and persistent storage
  Future<void> _toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Toggle favorite status
      if (favoriteEvents.contains(title)) {
        favoriteEvents.remove(title);
      } else {
        favoriteEvents.add(title);
      }
      // Persist changes to storage
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
          // Convert map data to Event object for EventCard widget
          final event = Event(
            id: index.toString(),
            title: events[index]["title"] ?? "",
            stage: events[index]["stage"] ?? "",
            startTime: DateTime.now(), // TODO: Replace with actual time
            endTime: DateTime.now().add(Duration(hours: 2)),
          );

          // Render event card with favorite functionality
          return EventCard(
            event: event,
            onFavorite: () => _toggleFavorite(event.title),
            onTap: () {
              // Provide user feedback on event selection
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
