// for all related system design configurations

import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:flutter/material.dart';

extension System on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void openDrawer() {
    Scaffold.of(this).openDrawer();
  }

  void showAlertDialog(String message) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // get dimension from build context
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
