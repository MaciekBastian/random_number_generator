import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'generator_repository.dart';

@LazySingleton(as: GeneratorRepository)
class GeneratorRepositoryImpl implements GeneratorRepository {
  @override
  Future<List<int>> getNumbersStake1() async {
    final data = await rootBundle.loadString('assets/females.json');
    final jsonData = json.decode(data) as List;
    return jsonData.map((e) => e as int).toList();
  }

  @override
  Future<List<int>> getNumbersStake2() async {
    final data = await rootBundle.loadString('assets/males.json');
    final jsonData = json.decode(data) as List;
    return jsonData.map((e) => e as int).toList();
  }

  @override
  (int, List<int>) randomNumber(List<int> numbers, List<int> history) {
    if (numbers.isEmpty) {
      return (0, []);
    }
    final copy = [...numbers]..shuffle();

    late int drawn;

    // generate standard random value is there is no last generated number
    if (history.isEmpty) {
      final random = Random.secure().nextInt(copy.length);
      drawn = copy[random];
    } else {
      // get recent drawn
      final lastDrawn = history.last;
      // get numbers that are not next to recent drawn
      final validNumbers =
          numbers.where((element) => (element - lastDrawn).abs() > 1).toList();
      // if there is no such numbers, generate standard random number
      if (validNumbers.isEmpty) {
        final random = Random.secure().nextInt(copy.length);
        drawn = copy[random];
      } else {
        // if there are numbers that are not next to recent drawn, generate from those numbers
        // it ensures drawn feels random to human
        final random = Random.secure().nextInt(validNumbers.length);
        drawn = validNumbers[random];
      }
    }

    copy.remove(drawn);
    return (drawn, copy);
  }
}
