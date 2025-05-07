/// HomeScreen serves as the main dashboard for the festival app.
/// Features:
/// - Personalized welcome message
/// - Countdown to next event
/// - Quick access to key features (Map, Friends, Notifications, Weather)
/// - Festival information hub
/// - Latest announcements and weather updates
library;

import 'dart:async';
import 'package:flutter/material.dart';
//import '../widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// User information - would normally be fetched from user profile
  final String userName = "Boris";
  final String festivalName = "Summer Music Fest 2025";

  final String nextEventTitle = "Headliner Performance";

  final int friendsOnline = 5;

  final int unreadNotifications = 3;

  final String weather = "Sunny, 25°C";

  /// Countdown timer state
  late Timer _timer;
  Duration _countdown = const Duration(hours: 0, minutes: 30);

  @override
  void initState() {
    super.initState();
    // Periodic timer to update countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_countdown.inSeconds > 0) {
          _countdown = _countdown - const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Format duration for display
  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return "$hours h $minutes m";
    } else if (minutes > 0) {
      return "$minutes m $seconds s";
    } else {
      return "$seconds s";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Large app bar with festival welcome message
          SliverAppBar.large(
            floating: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $userName!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    festivalName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main content area
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildNextEventSection(context),
                const SizedBox(height: 24),
                _buildQuickActionsGrid(context),
                const SizedBox(height: 24),
                _buildInfoSection(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Next event card with countdown
  Widget _buildNextEventSection(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Next Event',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              nextEventTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            // Countdown display with animation
            Text(
              'Starts in ${_formatDuration(_countdown)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Quick access grid for main app features
  Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        // TODO: Implement the navigation for these cards
        _buildActionCard(
          context,
          Icons.map,
          'Festival Map',
          'View venue map',
          () => Navigator.pushNamed(context, '/map'),
        ),
        _buildActionCard(
          context,
          Icons.people,
          'Friends',
          '$friendsOnline online',
          () => Navigator.pushNamed(context, '/friends'),
        ),
        _buildActionCard(
          context,
          Icons.notifications,
          'Notifications',
          '$unreadNotifications unread',
          () => Navigator.pushNamed(context, '/notifications'),
        ),
        _buildActionCard(context, Icons.wb_sunny, 'Weather', weather, () {}),
      ],
    );
  }

  /// Individual action card for quick access grid
  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    // Card with icon and text
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Festival information section with important details
  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            'Festival Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // List of important festival information
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.schedule,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Festival Hours'),
                subtitle: const Text('12:00 PM - 11:00 PM'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.medical_services,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('First Aid Locations'),
                subtitle: const Text('Main Entrance & Food Court'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
