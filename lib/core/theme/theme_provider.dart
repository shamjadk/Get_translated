import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/core/theme/theme.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeData build() {
    return darkTheme;
  }

  void switchTheme() {
    if (state.brightness == Brightness.light) {
      state = darkTheme;
    } else {
      state = lightTheme;
    }
  }
}
