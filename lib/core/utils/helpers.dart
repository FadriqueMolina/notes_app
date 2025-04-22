import 'package:flutter/material.dart';
import 'package:notes_app/main.dart' show scaffoldMessengerKey;

void showGlobalSnackBar(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
