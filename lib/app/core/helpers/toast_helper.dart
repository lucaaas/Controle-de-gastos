import 'package:flutter/material.dart';

class ToastHelper {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Entrada salva'),
      ),
    );
  }
}
