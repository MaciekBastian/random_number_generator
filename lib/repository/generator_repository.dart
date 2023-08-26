abstract class GeneratorRepository {
  Future<List<int>> getNumbersStake1();

  Future<List<int>> getNumbersStake2();

  (int, List<int>) randomNumber(List<int> numbers, List<int> history);
}
