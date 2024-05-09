import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/controller/navigator_controller.dart';
import 'package:translate_it/core/snack_bar.dart';
import 'package:translate_it/core/theme.dart';
import 'package:translate_it/controller/provider/translator_provider.dart';
import 'package:translate_it/model/history_entity_model.dart';
import 'package:translate_it/view/pages/history_page.dart';
import 'package:translate_it/view/pages/lang_selection_page.dart';
import 'package:translate_it/view/widgets/bottom_elevated_button_widget.dart';
import 'package:translate_it/view/widgets/elevated_button_widget.dart';
import 'package:translate_it/view/widgets/text_button_widget.dart';
import 'package:translate_it/view/widgets/text_field_widget.dart';

final fromLangBtnNameProvider = StateProvider<String>((ref) {
  return 'English';
});
final toLangBtnNameProvider = StateProvider<String>((ref) {
  return 'English';
});

class TranslatePage extends HookConsumerWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final translateController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Get Translated',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                  onPressed: () => navPush(context, const HistoryPage()),
                  icon: const Icon(Icons.history))
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
                  TextFieldWidget(
                    controller: translateController,
                    onSubmitted: (value) {
                      ref.read(translatorProvider.notifier).getTranslated(
                            translateController.text,
                          );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButtonWidget(
                        btnName: 'Paste',
                        onPressed: () async {
                          final copiedText =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          translateController.text = copiedText!.text!;
                          log(copiedText.text.toString());
                        },
                      ),
                      TextButtonWidget(
                        btnName: 'Clear',
                        onPressed: () {
                          ref.read(translatorProvider.notifier).clearState();
                          translateController.clear();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 1)),
                    child: Text(
                      ref.watch(translatorProvider).translatedResult,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButtonWidget(
                        btnName: ref.watch(fromLangBtnNameProvider),
                        onPressed: () {
                          navPush(context,
                              const LangSelectionPage(isFromLang: true));
                        },
                      ),
                      const Icon(Icons.arrow_right_alt_outlined),
                      ElevatedButtonWidget(
                        btnName: ref.watch(toLangBtnNameProvider),
                        onPressed: () {
                          navPush(context,
                              const LangSelectionPage(isFromLang: false));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: BottomElevatedButtonWidget(
            child: isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('Translate'),
            onPressed: () async {
              if (translateController.text.isNotEmpty) {
                isLoading.value = true;
                await ref.read(translatorProvider.notifier).getTranslated(
                      translateController.text,
                    );
                isLoading.value = false;
                final historyModel = HistoryEntityModel(
                  sourceText: translateController.text,
                  resultText:
                      ref.watch(translatorProvider).translatedResult.isEmpty
                          ? 'sss'
                          : ref.watch(translatorProvider).translatedResult,
                );
                log('${historyModel.sourceText!}: ${historyModel.resultText} ${historyModel.id}');
                ref
                    .read(translatorProvider.notifier)
                    .addToHistory(historyModel);
              } else {
                showSnackBar('Please enter something');
              }
            },
          )),
    );
  }
}
