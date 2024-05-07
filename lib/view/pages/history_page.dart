import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/controller/provider/translator_provider.dart';
import 'package:translate_it/core/theme.dart';
import 'package:translate_it/view/widgets/bottom_elevated_button_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ref.watch(translatorProvider).history != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data = ref.watch(translatorProvider).history;
                    log(data.toString());
                    return InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => InkWell(
                          onTap: () {
                            ref
                                .read(translatorProvider.notifier)
                                .deleteFromHistory(data[index].id, context);
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
                  itemCount: ref.watch(translatorProvider).history!.length),
            )
          : const Center(
              child: Text('No history'),
            ),
      bottomNavigationBar: BottomElevatedButtonWidget(
        btnName: 'Clear',
        onPressed: () {
          ref.read(translatorProvider.notifier).clearHistory();
        },
      ),
    );
  }
}
