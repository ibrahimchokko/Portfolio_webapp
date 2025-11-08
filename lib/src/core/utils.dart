import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  // Format DateTime to readable string
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Show SnackBar
  static void showSnackBar(BuildContext context, String message, {Color color = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
