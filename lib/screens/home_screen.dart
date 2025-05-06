import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.map,
      'label': 'Festival Map',
      'route': '/map',
    },
    {
      'icon': Icons.schedule,
      'label': 'My Schedule',
      'route': '/schedule',
    },
    // Add more features...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/festival_header.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => FeatureCard(
                  icon: features[index]['icon'],
                  label: features[index]['label'],
                  onTap: () => Navigator.pushNamed(context, features[index]['route']),
                ),
                childCount: features.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
