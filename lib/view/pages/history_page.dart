import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/controller/provider/translator_provider.dart';
import 'package:translate_it/core/theme.dart';
import 'package:translate_it/view/widgets/app_bar_widget.dart';
import 'package:translate_it/view/widgets/back_button_widget.dart';
import 'package:translate_it/view/widgets/bottom_elevated_button_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'History', leading: BackButtonWidget()),
      body: ref.watch(translatorProvider).history != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = ref.watch(translatorProvider).history;
                          return InkWell(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => InkWell(
                                onTap: () {
                                  ref
                                      .read(translatorProvider.notifier)
                                      .deleteFromHistory(
                                          data[index].id, context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 16),
                                  height: 50,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(8))),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data![index].sourceText!),
                                    Text(data[index].resultText!)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount:
                            ref.watch(translatorProvider).history!.length),
                    const SizedBox(
                      height: 72,
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: Text('No history'),
            ),
      floatingActionButton: BottomElevatedButtonWidget(
        btnName: 'Clear',
        onPressed: () {
          ref.read(translatorProvider.notifier).clearHistory();
        },
      ),
    );
  }
}
