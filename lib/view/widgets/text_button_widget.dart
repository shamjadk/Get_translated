import 'package:flutter/material.dart';
import 'package:translate_it/core/theme.dart';

class TextButtonWidget extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  const TextButtonWidget({super.key, required this.btnName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
                          onPressed: onPressed,
                          child: Text(
                            btnName,
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                            ),
                          ));
  }
}