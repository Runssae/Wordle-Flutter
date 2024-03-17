// Import Flutter for building UI elements
import 'package:flutter/material.dart';

// Function to show a quick dialog box
void runQuickBox({required BuildContext context, required String message}) {
  // Schedule the dialog to show after the next frame renders
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    showDialog(
      // Prevent dismissal by tapping outside the dialog
      barrierDismissible: false,
      // Make the background transparent
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        // Wait 1 second before potentially dismissing the dialog
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.maybePop(context); // Try to dismiss the dialog
        });

        // Show an alert dialog with the provided message
        return AlertDialog(
          title: Text(
            message,
            textAlign: TextAlign.center, // Center the text
          ),
        );
      },
    );
  });
}
