import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translate_it/view/controller/provider/translator_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Translate It',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: inputController,
            decoration: const InputDecoration(hintText: 'Enter'),
          ),
          Column(
            children: [
              Text(ref.watch(translatorProvider)),
              TextButton(
                  onPressed: () {
                    ref
                        .read(translatorProvider.notifier)
                        .getTranslated(inputController.text);
                  },
                  child: const Text('translate'))
            ],
          ),
        ],
      ),
    );
  }
}
