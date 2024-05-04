import 'dart:developer';

import 'package:translator/translator.dart';

class Method {
  static var translator = GoogleTranslator();

  static Stream<Translation> result(String? text) async* {
    if (text!.isEmpty) {
      text = 'Enter something';
    } else {
      text = text;
    }
    final result = await translator.translate(text, from: 'en', to: 'ml');
    log(result.toString());
    yield result;
  }
}