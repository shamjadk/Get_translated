import 'package:flutter/material.dart';

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
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
