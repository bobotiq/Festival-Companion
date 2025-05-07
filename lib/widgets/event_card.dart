/// EventCard is a reusable widget that displays event information in a card format.
/// Features:
/// - Displays event time, title, and stage
/// - Shows favorite status with an interactive star button
/// - Handles tap interactions for viewing event details
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  /// The event data to display
  final Event event;

  /// Callback function when favorite button is pressed
  final VoidCallback onFavorite;

  /// Callback function when card is tapped
  final VoidCallback onTap;

  const EventCard({
    required this.event,
    required this.onFavorite,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Time container with themed background
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    DateFormat('HH:mm').format(event.startTime),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Event details section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      event.stage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              // Favorite button with animation
              IconButton(
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    event.isFavorite ? Icons.star : Icons.star_border,
                    key: ValueKey(event.isFavorite),
                    color:
                        event.isFavorite
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                  ),
                ),
                onPressed: onFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
