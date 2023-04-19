import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final User user;
  const CustomAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Color profileBackgroundColor = (Colors.primaries.toList()..shuffle()).first.shade600;
    return Container(
      child: user.photoURL == null
          ? CircleAvatar(
              radius: 48,
              backgroundColor: profileBackgroundColor,
              child: Text(
                user.displayName![0],
                style: const TextStyle(
                  fontSize: 56,
                  color: Colors.white,
                ),
              ),
            )
          : CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                user.photoURL!,
              ),
            ),
    );
  }
}
