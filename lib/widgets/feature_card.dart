/// FeatureCard is a reusable widget for displaying feature shortcuts on the home screen dashboard.
/// Features:
/// - Icon and label display
/// - Tap handling for navigation
/// - Consistent styling with app theme
library;

import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  /// Icon to display for the feature
  final IconData icon;

  /// Text label describing the feature
  final String label;

  /// Optional callback for tap handling
  final VoidCallback? onTap;

  const FeatureCard({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              // Feature icon with themed color
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              // Feature label
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
