import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translate_it/view/controller/provider/translator_provider.dart';
import 'package:translate_it/view/pages/method.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = TextEditingController(text: 'horse');

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
          StreamBuilder(
              stream: ref
                  .watch(translatorProvider.notifier)
                  .gettranslated(inputController.text),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(snapshot.data.toString()),
                    TextButton(
                        onPressed: () {
                          Method.result(inputController.text);
                        },
                        child: const Text('translate'))
                  ],
                );
              }),
        ],
      ),
    );
  }
}
