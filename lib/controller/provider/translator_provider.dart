import 'dart:developer';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/controller/objectbox_store.dart';
import 'package:translate_it/core/snack_bar.dart';
import 'package:translate_it/model/history_entity_model.dart';
import 'package:translate_it/objectbox.g.dart';
import 'package:translator/translator.dart';

part 'translator_provider.g.dart';

@riverpod
class Translator extends _$Translator {
  GoogleTranslator? translator;
  late Box<HistoryEntityModel> box;
  @override
  String build() {
    translator = GoogleTranslator();
    box = HistoryObjectboxStore.instance.historyBox;
    return '';
  }

  Future<void> getTranslated(String? text) async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        if (text!.isEmpty) {
          state = '';
        }
        final result =
            await translator!.translate(text.trim(), from: 'en', to: 'ml');

        state = result.toString();
      } else {
        showSnackBar('Internet connection is required');
      }
    } catch (e) {
      log(e.toString());
      state = '';
    }
  }

  Future<void> addToHistory(HistoryEntityModel model) async {
    box.put(model);
  }

  Future<List<HistoryEntityModel>> getHistory() async {
    return box.getAll();
  }

  Future<void> deleteFromHistory(int id) async {
    box.remove(id);
  }

  Future<void> clearHistory() async {
    box.removeAll();
  }
}
