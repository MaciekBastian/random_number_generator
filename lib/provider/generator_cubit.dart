import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../repository/generator_repository.dart';

part 'generator_cubit.freezed.dart';
part 'generator_state.dart';

@singleton
class GeneratorCubit extends Cubit<GeneratorState> {
  GeneratorCubit(this._repo) : super(GeneratorState());

  final GeneratorRepository _repo;

  Future<void> init() async {
    final stake1 = await _repo.getNumbersStake1();
    final stake2 = await _repo.getNumbersStake2();
    emit(
      state.copyWith(
        stake1: stake1,
        stake2: stake2,
      ),
    );
  }

  Future<void> drawStake1() async {
    final numbers = state.stake1;
    if (numbers.isEmpty) {
      return;
    }
    emit(state.copyWith(showAnimation: true));
    await Future.delayed(const Duration(seconds: 2));
    final draw = _repo.randomNumber(numbers, state.stake1History);
    emit(
      state.copyWith(
        showAnimation: false,
        stake1: draw.$2,
        mostRecent: draw.$1,
        stake1History: [...state.stake1History, draw.$1],
      ),
    );
  }

  Future<void> drawStake2() async {
    final numbers = state.stake2;
    if (numbers.isEmpty) {
      return;
    }
    emit(state.copyWith(showAnimation: true));
    await Future.delayed(const Duration(seconds: 2));
    final draw = _repo.randomNumber(numbers, state.stake2History);
    emit(
      state.copyWith(
        showAnimation: false,
        stake2: draw.$2,
        mostRecent: draw.$1,
        stake2History: [...state.stake2History, draw.$1],
      ),
    );
  }
}
