part of 'generator_cubit.dart';

@freezed
class GeneratorState with _$GeneratorState {
  factory GeneratorState({
    int? mostRecent,
    @Default(false) bool showAnimation,
    @Default([]) List<int> stake1,
    @Default([]) List<int> stake2,
    @Default([]) List<int> stake1History,
    @Default([]) List<int> stake2History,
  }) = _GeneratorState;
}
