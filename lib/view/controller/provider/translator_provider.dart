import 'dart:developer';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translator/translator.dart';

part 'translator_provider.g.dart';

@riverpod
class Translator extends _$Translator {
  GoogleTranslator? translator;
  @override
  Stream<String> build() async* {
    translator = GoogleTranslator();
    yield '';
  }

  Stream<String> gettranslated(String? text) async* {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        log('true');
        if (text!.isEmpty) {
          text = 'Enter something';
        } else {
          text = text;
        }
        final result = await translator!.translate(text, from: 'en', to: 'ml');
        log(result.toString());
        state = AsyncValue.data(result.toString());
        yield result.toString();
      } else {
        log('false');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
