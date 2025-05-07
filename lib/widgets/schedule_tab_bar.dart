import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Event> _allEvents = [];
  final List<Event> _favoriteEvents = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInitialEvents();
    _loadFavorites();
  }

  void _loadInitialEvents() {
    // Replace with real data source
    _allEvents.addAll([
      Event(
        id: '1',
        title: 'Main Stage Opening',
        stage: 'Main Stage',
        startTime: DateTime(2025, 6, 15, 18, 0),
        endTime: DateTime(2025, 6, 15, 20, 0),
      ),
      // Add more events...
    ]);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favoriteEvents') ?? [];
    setState(() {
      for (var event in _allEvents) {
        event.isFavorite = favorites.contains(event.id);
      }
      _favoriteEvents.addAll(_allEvents.where((e) => e.isFavorite));
    });
  }

  Future<void> _toggleFavorite(Event event) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      event.isFavorite = !event.isFavorite;
      if (event.isFavorite) {
        _favoriteEvents.add(event);
      } else {
        _favoriteEvents.removeWhere((e) => e.id == event.id);
      }
    });
    final favorites = _favoriteEvents.map((e) => e.id).toList();
    await prefs.setStringList('favoriteEvents', favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'All Events'), Tab(text: 'My Schedule')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventList(_allEvents),
          _buildEventList(_favoriteEvents),
        ],
      ),
    );
  }

  Widget _buildEventList(List<Event> events) {
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => _buildEventTile(events[index]),
    );
  }

  Widget _buildEventTile(Event event) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showEventDetails(event),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
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
                    Text(
                      '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
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
                onPressed: () => _toggleFavorite(event),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.location_on, 'Stage', event.stage),
                SizedBox(height: 16),
                _buildDetailRow(
                  Icons.access_time,
                  'Time',
                  '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                ),
              ],
            ),
            actions: [
              TextButton.icon(
                icon: Icon(event.isFavorite ? Icons.star : Icons.star_border),
                label: Text(
                  event.isFavorite
                      ? 'Remove from favorites'
                      : 'Add to favorites',
                ),
                onPressed: () {
                  _toggleFavorite(event);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
