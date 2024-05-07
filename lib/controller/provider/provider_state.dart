import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:translate_it/model/history_entity_model.dart';

part 'provider_state.freezed.dart';

@freezed
class ProviderState with _$ProviderState {
  factory ProviderState({
    required String translatedResult,
    required List<HistoryEntityModel>? history,
  }) = _ProviderState;
}
