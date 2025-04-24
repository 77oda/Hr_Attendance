import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 3),
    ),
  );
}
