import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helper to format dates
String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('MMM dd, yyyy');
  return formatter.format(date);
}

// Helper to show Snackbar messages
void showSnackBar(BuildContext context, String message, {Color backgroundColor = Colors.black}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Helper to validate email
bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

// Helper to generate random colors
Color getRandomColor() {
  return Color((0xFF000000 + (0x00FFFFFF * (1 + 0.5) * (0.5))).toInt());
}