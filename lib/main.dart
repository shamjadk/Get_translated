import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translate_it/controller/objectbox_store.dart';
import 'package:translate_it/view/pages/translate_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HistoryObjectboxStore.create();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const TranslatePage(),
    );
  }
}
