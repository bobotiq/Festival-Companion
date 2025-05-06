import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  const ProfileAvatar({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.grey[200],
      backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      child:
          imageUrl.isEmpty
              ? Icon(Icons.person, size: 28, color: Colors.grey[600])
              : null,
      // For advanced error handling, use cached_network_image
    );
  }
}
