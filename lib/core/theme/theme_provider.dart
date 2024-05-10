import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/core/shared_prefernces.dart/store_theme.dart';
import 'package:translate_it/core/theme/theme.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeData build() {
    return lightTheme;
  }

  void switchTheme() {
    final isDark = state.brightness == Brightness.dark;
    isDark ? state = lightTheme : state = darkTheme;
    StoreTheme.setTheme(isDark);
  }

  Future<void> initTheme() async {
    final isDarkActive = StoreTheme.getTheme();
    await isDarkActive ? state = darkTheme : state = lightTheme;
  }
}
