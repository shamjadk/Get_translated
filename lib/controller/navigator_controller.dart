import 'package:flutter/material.dart';

navPush(BuildContext context, Widget page) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}

navPushReplace(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}
