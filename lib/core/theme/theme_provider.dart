import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/core/theme/store_theme.dart';
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
    log(isDark.toString());
  }

  Future<void> initTheme() async {
    final isDarkActive = StoreTheme.getTheme();

    await isDarkActive ? state = darkTheme : state = lightTheme;
  }
}
