import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/controller/objectbox_store.dart';
import 'package:translate_it/controller/provider/provider_state.dart';
import 'package:translate_it/core/snack_bar.dart';
import 'package:translate_it/model/history_entity_model.dart';
import 'package:translate_it/objectbox.g.dart';
import 'package:translator/translator.dart';

part 'translator_provider.g.dart';

@riverpod
class Translator extends _$Translator {
  GoogleTranslator? translator;
  late final Box<HistoryEntityModel> box;
  @override
  ProviderState build() {
    translator = GoogleTranslator();
    box = HistoryObjectboxStore.instance.historyBox;
    return ProviderState(translatedResult: '', history: box.getAll());
  }

  Future<void> getTranslated(String? text) async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        final result =
            await translator!.translate(text!.trim(), from: 'en', to: 'ml');
        state = state.copyWith(translatedResult: result.toString());
      } else {
        showSnackBar('Internet connection is required');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToHistory(HistoryEntityModel model) async {
    if (state.translatedResult.isNotEmpty) {
      try {
        box.put(model);
        log('${model.resultText!} ${model.sourceText} ${model.id}');
        state = state.copyWith(history: box.getAll());
        log('added to history');
      } catch (e) {
        log(e.toString());
      }
    } else {
      log('translated result state is empty, cannot add to history');
    }
  }

  Future<void> deleteFromHistory(int id, BuildContext context) async {
    try {
      box.remove(id);
      state = state.copyWith(history: box.getAll());
      Navigator.pop(context);
      showSnackBar('Deleted');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clearHistory() async {
    try {
      box.removeAll();
      state = state.copyWith(history: box.getAll());
    } catch (e) {
      log(e.toString());
    }
  }

  void clearState() {
    state = state.copyWith(translatedResult: '');
  }
}
