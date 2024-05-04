import 'package:flutter/material.dart';
import 'package:translate_it/main.dart';

void shownackBBar(String message) {
  MyApp.scaffoldMessengerKey.currentState!
      .showSnackBar(SnackBar(content: Text(message)));
}
