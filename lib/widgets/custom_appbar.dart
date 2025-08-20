import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
      ),
    ],
  );
}
