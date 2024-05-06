import 'package:flutter/material.dart';
import 'package:translate_it/core/theme.dart';

class BottomElevatedButtonWidget extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  const BottomElevatedButtonWidget({super.key, required this.btnName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white),
            onPressed: onPressed,
            child:  Text(
              btnName,
            ),
          ),
        ),
      );
  }
}