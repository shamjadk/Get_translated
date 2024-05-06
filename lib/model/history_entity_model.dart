import 'package:objectbox/objectbox.dart';

@Entity()
class HistoryEntityModel {
  @Id()
  int id = 0;
  String sourceText;
  String resultText;

  HistoryEntityModel(
      {required this.id, required this.sourceText, required this.resultText});
}
