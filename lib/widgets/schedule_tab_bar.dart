import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
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
          tabs: const [
            Tab(text: 'All Events'),
            Tab(text: 'My Schedule'),
          ],
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
      return Center(child: Text('No events found', style: Theme.of(context).textTheme.bodyLarge));
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => _buildEventTile(events[index]),
    );
  }

  Widget _buildEventTile(Event event) {
    return ListTile(
      leading: IconButton(
        icon: Icon(event.isFavorite ? Icons.star : Icons.star_border),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () => _toggleFavorite(event),
      ),
      title: Text(event.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.stage),
          Text(
            '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showEventDetails(event),
    );
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stage: ${event.stage}'),
            Text('Time: ${DateFormat('HH:mm').format(event.startTime)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
