import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Example data (replace with real data or state management as needed)
  final String userName = 'Bob';
  final String festivalName = 'Sunshine Music Fest 2025';
  final String nextEventTitle = 'Main Stage: DJ Aurora';
  final DateTime nextEventTime = DateTime(2025, 6, 15, 18, 30);
  final String weather = 'Sunny, 23°C';
  final int unreadNotifications = 3;
  final int friendsOnline = 2;

  late Timer _timer;
  Duration _countdown = Duration();

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final diff = nextEventTime.difference(now);
    setState(() {
      _countdown = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    if (d.inSeconds <= 0) return "Now!";
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    if (hours > 0) {
      return "$hours h $minutes m $seconds s";
    } else if (minutes > 0) {
      return "$minutes m $seconds s";
    } else {
      return "$seconds s";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome, $userName!',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 26),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    festivalName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildNextEventCard(context),
            const SizedBox(height: 16),
            _buildWeatherCard(context),
            const SizedBox(height: 16),
            _buildNotificationsCard(context),
            const SizedBox(height: 16),
            _buildFriendsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNextEventCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.event, color: Colors.blue, size: 36),
        title: const Text('Next Event'),
        subtitle: Text(
          '$nextEventTitle\nStarts in ${_formatDuration(_countdown)}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pushNamed(context, '/schedule'),
          tooltip: 'Go to Schedule',
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.wb_sunny, color: Colors.orange, size: 36),
        title: const Text('Weather'),
        subtitle: Text(weather),
        trailing: IconButton(
          icon: const Icon(Icons.map),
          onPressed: () => Navigator.pushNamed(context, '/map'),
          tooltip: 'View Festival Map',
        ),
      ),
    );
  }

  Widget _buildNotificationsCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.red, size: 36),
        title: const Text('Notifications'),
        subtitle: Text('$unreadNotifications unread'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
          tooltip: 'View Notifications',
        ),
      ),
    );
  }

  Widget _buildFriendsCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.people, color: Colors.green, size: 36),
        title: const Text('Friends Online'),
        subtitle: Text('$friendsOnline online'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pushNamed(context, '/friends'),
          tooltip: 'View Friends',
        ),
      ),
    );
  }
}
