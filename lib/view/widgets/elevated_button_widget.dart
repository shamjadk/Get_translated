import 'package:flutter/material.dart';
import 'package:translate_it/core/theme.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  const ElevatedButtonWidget(
      {super.key, required this.btnName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            shadowColor: Colors.black,
            elevation: 4,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white),
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.center,
          btnName,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
