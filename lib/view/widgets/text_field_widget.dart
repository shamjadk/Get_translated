import 'package:flutter/material.dart';
import 'package:translate_it/core/theme/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  const TextFieldWidget(
      {super.key, required this.controller, this.onSubmitted, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      controller: controller,
      maxLines: null,
      cursorColor: AppTheme.primaryInLight,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.primaryInLight, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.primaryInLight, width: 1)),
          hintText: 'Enter something',
          hintStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
    );
  }
}
