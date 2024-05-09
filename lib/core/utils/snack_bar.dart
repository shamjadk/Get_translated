import 'package:flutter/material.dart';
import 'package:translate_it/main.dart';

void showSnackBar(String message) {
  MyApp.scaffoldMessengerKey.currentState!
      .showSnackBar(SnackBar(content: Text(message)));
}
