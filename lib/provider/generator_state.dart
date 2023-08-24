part of 'generator_cubit.dart';

@freezed
class GeneratorState with _$GeneratorState {
  factory GeneratorState({
    required int maxNumber,
    int? generated,
  }) = _GeneratorState;
}
