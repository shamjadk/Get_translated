import 'package:flutter/material.dart';
import 'package:translate_it/core/theme.dart';

class BottomElevatedButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const BottomElevatedButtonWidget(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: MediaQuery.sizeOf(context).width - 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 4,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
