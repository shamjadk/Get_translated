// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/controller/provider/translator_provider.dart';
import 'package:translate_it/core/langs.dart';
import 'package:translate_it/view/pages/translate_page.dart';
import 'package:translate_it/view/widgets/app_bar_widget.dart';
import 'package:translate_it/view/widgets/back_button_widget.dart';
import 'package:translate_it/view/widgets/text_field_widget.dart';

class LangSelectionPage extends HookConsumerWidget {
  final bool isFromLang;
  const LangSelectionPage({super.key, required this.isFromLang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedLangCode = useState<String>('');
    final _selectedLang = useState<String>('');
    final _selectedIndex = useState<int>(-1);
    final searchController = useTextEditingController();

    void changeLang() {
      isFromLang
          ? (
              ref.read(fromLangCodeProvider.notifier).state =
                  _selectedLangCode.value,
              ref.read(fromLangBtnNameProvider.notifier).state =
                  _selectedLang.value
            )
          : (
              ref.read(toLangCodeProvider.notifier).state =
                  _selectedLangCode.value,
              ref.read(toLangBtnNameProvider.notifier).state =
                  _selectedLang.value
            );

      log('selected from ${ref.watch(fromLangCodeProvider)} to ${ref.watch(toLangCodeProvider)}');
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          leading: const BackButtonWidget(),
          title: 'Select language',
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFieldWidget(
                controller: searchController,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  changeLang();
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(Icons.done))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: Langs.langs.length,
                  itemBuilder: (context, index) {
                    final List<MapEntry<String, String>> data =
                        Langs.languages.entries.toList();
                    return InkWell(
                        onTap: () {
                          _selectedIndex.value = index;
                          _selectedLangCode.value =
                              data[_selectedIndex.value].value;
                          _selectedLang.value = data[_selectedIndex.value].key;
                        },
                        child: Container(
                            color: index == _selectedIndex.value
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            width: MediaQuery.sizeOf(context).width,
                            height: 40,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(data[index].key))));
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
