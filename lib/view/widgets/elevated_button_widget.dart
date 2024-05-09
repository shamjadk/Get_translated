import 'package:flutter/material.dart';

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
