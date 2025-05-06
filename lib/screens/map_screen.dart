import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the app's theme
    return Center(
      child: Card(
        margin: EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        child: Container(
          width: 340,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.colorScheme.surface,
          ),
          child: Center(
            child: Text(
              'Festival Map Coming Soon',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
