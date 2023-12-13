import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  Color color = Colors.red,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Center(
          child: Text(
            message,
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
