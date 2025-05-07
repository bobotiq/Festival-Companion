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
      body: CustomScrollView(
        slivers: [
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

  Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
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

  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
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
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onTap: () => Navigator.pushNamed(context, '/schedule'),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.local_parking,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Parking Information'),
                subtitle: const Text('Available spots: 250+'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.food_bank,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Food & Drinks'),
                subtitle: const Text('20+ vendors available'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.medical_services,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Emergency Services'),
                subtitle: const Text('First aid locations & contact info'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
