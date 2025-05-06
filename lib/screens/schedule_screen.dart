import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  // List of events with time, title, and stage
  final List<Map<String, String>> events = [
    {"time": "12:00", "title": "Opening Ceremony", "stage": "Main Stage"},
    {"time": "13:30", "title": "Rock Band", "stage": "Stage A"},
    {"time": "15:00", "title": "DJ Set", "stage": "Dance Tent"},
    {"time": "16:30", "title": "Food Tasting", "stage": "Food Court"},
    {"time": "18:00", "title": "Headliner", "stage": "Main Stage"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the app's theme
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                event["time"]!.split(':')[0], // Display hour as text
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
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: theme.colorScheme.secondary,
              size: 18,
            ),
            onTap: () {
              // Show a snackbar when an event is tapped
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
