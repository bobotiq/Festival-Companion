import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl; // URL of the avatar image
  const ProfileAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl), // Load image from the network
      radius: 26, // Set the size of the avatar
    );
  }
}
