import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translate_it/controller/objectbox_store.dart';
import 'package:translate_it/controller/provider/provider_state.dart';
import 'package:translate_it/core/utils/langs.dart';
import 'package:translate_it/core/utils/snack_bar.dart';
import 'package:translate_it/model/history_entity_model.dart';
import 'package:translate_it/objectbox.g.dart';
import 'package:translator/translator.dart';

part 'translator_provider.g.dart';

@riverpod
class Translator extends _$Translator {
  GoogleTranslator? translator;
  final Box<HistoryEntityModel> box = HistoryObjectboxStore.instance.historyBox;
  @override
  ProviderState build() {
    translator = GoogleTranslator();
    return ProviderState(translatedResult: '', history: box.getAll());
  }

  Future<void> getTranslated(
    String? text,
  ) async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        final result = await translator!.translate(text!.trim(),
            from: ref.watch(fromLangCodeProvider),
            to: ref.watch(toLangCodeProvider));
        log('translated from ${ref.watch(fromLangCodeProvider)} to ${ref.watch(toLangCodeProvider)}');
        state = state.copyWith(translatedResult: result.toString());
      } else {
        showSnackBar('Internet connection is required');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToHistory(HistoryEntityModel model) async {
    try {
      box.put(model);
      log('${model.sourceText!}: ${model.resultText} ${model.id}');
      state = state.copyWith(history: box.getAll());
      log('added to history');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteFromHistory(int id, BuildContext context) async {
    try {
      box.remove(id);
      state = state.copyWith(history: box.getAll());
      Navigator.pop(context);
      // showSnackBar('Deleted');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clearHistory() async {
    try {
      if (state.history!.isNotEmpty) {
        box.removeAll();
        state = state.copyWith(history: box.getAll());
        showSnackBar('Cleared history');
      } else {
        showSnackBar('Nothing to clear');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<MapEntry<String, String>>? searchLang(String text) {
    final List<MapEntry<String, String>> langList =
        Langs.languages.entries.toList();
    final searchResults = langList
        .where((element) =>
            element.key.toLowerCase().startsWith(text.toLowerCase().trim()))
        .toList();
    if (text.isEmpty) {
      log('Empty input');
    } else {
      return searchResults;
    }
    return null;
  }

  void clearState() {
    state = state.copyWith(translatedResult: '');
  }
}

final fromLangCodeProvider = StateProvider<String>((ref) {
  return 'en';
});
final toLangCodeProvider = StateProvider<String>((ref) {
  return 'en';
});
