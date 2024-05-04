import 'dart:developer';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/core/snack_bar.dart';
import 'package:translator/translator.dart';

part 'translator_provider.g.dart';

@riverpod
class Translator extends _$Translator {
  GoogleTranslator? translator;
  @override
  String build() {
    translator = GoogleTranslator();
    return '';
  }

  Future<void> getTranslated(String? text) async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        final result = await translator!.translate(text!, from: 'en', to: 'ml');
        log(result.toString());
        state = result.toString();
      } else {
        showSnackBar('Internet connection is required');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
