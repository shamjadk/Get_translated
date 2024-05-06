import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/core/theme.dart';
import 'package:translate_it/view/controller/provider/translator_provider.dart';
import 'package:translate_it/view/pages/history_page.dart';
import 'package:translate_it/view/widgets/bottom_elevated_button_widget.dart';

class TranslatePage extends HookConsumerWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translateController = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Translate It',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    )),
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
                TextField(
                  onChanged: (value) {
                    ref
                        .read(translatorProvider.notifier)
                        .getTranslated(translateController.text);
                  },
                  onSubmitted: (value) {
                    ref
                        .read(translatorProvider.notifier)
                        .getTranslated(translateController.text);
                  },
                  controller: translateController,
                  maxLines: null,
                  cursorColor: AppTheme.primaryColor,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: AppTheme.primaryColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: AppTheme.primaryColor, width: 1)),
                      hintText: 'Enter something',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => translateController.clear(),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                        ),
                      )),
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
                      ref.watch(translatorProvider).isEmpty
                          ? 'Your result will appear here'
                          : ref.watch(translatorProvider),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomElevatedButtonWidget(
          btnName: 'Translate',
          onPressed: () {
            ref
                .read(translatorProvider.notifier)
                .getTranslated(translateController.text);
          },
        ));
  }
}
