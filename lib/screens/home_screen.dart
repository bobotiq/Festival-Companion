import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  // List of features with icons and labels
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.map_rounded, 'label': 'Festival Map'},
    {'icon': Icons.event_rounded, 'label': 'Event Schedule'},
    {'icon': Icons.people_rounded, 'label': 'Find Friends'},
    {'icon': Icons.notifications_rounded, 'label': 'Notifications'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the app's theme
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Welcome card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  Icon(
                    Icons.music_note_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to Festival Companion!',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your personal guide to an unforgettable festival experience.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Text('Explore Features', style: theme.textTheme.titleLarge),
          SizedBox(height: 20),
          // Grid of feature cards
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final feature = features[index];
              return FeatureCard(
                icon: feature['icon'],
                label: feature['label'],
              );
            },
          ),
        ],
      ),
    );
  }
}
