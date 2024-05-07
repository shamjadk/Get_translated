import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:translate_it/model/history_entity_model.dart';
import 'package:translate_it/objectbox.g.dart';
import 'package:path/path.dart' as path;

class HistoryObjectboxStore {
  static HistoryObjectboxStore? _instance;
  final Store store;
  late final Box<HistoryEntityModel> historyBox;

  HistoryObjectboxStore._create(this.store) {
    historyBox = store.box<HistoryEntityModel>();
  }

  static HistoryObjectboxStore get instance {
    return _instance!;
  }

  static Future<void> create() async {
    if (_instance == null) {
      try {
        final docsDir = await getApplicationDocumentsDirectory();
        final store = await openStore(
          directory: path.join(docsDir.path, 'history'),
        );
        _instance = HistoryObjectboxStore._create(store);
      } catch (e) {
        log('Error creating HistoryObjectboxStore: $e');
      }
    }
  }
}
