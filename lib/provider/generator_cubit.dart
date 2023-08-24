import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'generator_cubit.freezed.dart';
part 'generator_state.dart';

@singleton
class GeneratorCubit extends Cubit<GeneratorState> {
  GeneratorCubit() : super(GeneratorState(maxNumber: 0));

  void setMaxNumber(int maxNumber) {
    emit(state.copyWith(maxNumber: maxNumber, generated: null));
  }
}
