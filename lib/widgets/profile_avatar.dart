/// ProfileAvatar is a reusable circular avatar widget that displays user images
/// with an optional online status indicator.
/// Features:
/// - Circular avatar with network image
/// - Configurable size through radius parameter
/// - Online status indicator dot
/// - Fallback avatar for loading/error states
library;

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  /// URL for the user's avatar image
  final String imageUrl;

  /// Whether to show the online status indicator
  final bool isOnline;

  /// Size of the avatar (radius in pixels)
  final double radius;

  const ProfileAvatar({
    required this.imageUrl,
    this.isOnline = false,
    this.radius = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main avatar circle
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(imageUrl),
          // Fallback color if image fails to load
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        ),
        // Online status indicator
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.4,
              height: radius * 0.4,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
