import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon; // Icon for the feature
  final String label; // Label for the feature

  const FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the app's theme
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Show a snackbar when the card is tapped
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label feature coming soon!')),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: theme.colorScheme.primary),
              SizedBox(height: 14),
              Text(
                label,
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
