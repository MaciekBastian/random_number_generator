import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../provider/generator_cubit.dart';

class Drawing extends StatelessWidget {
  const Drawing({super.key});
  static const pageName = '/drawing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GeneratorCubit, GeneratorState>(
        bloc: BlocProvider.of<GeneratorCubit>(context),
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 120,
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                                child: Center(child: Text('KOBIETY')),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 80,
                                child: _history(state.stake1History),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 100,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                                child: Center(child: Text('MĘŻCZYŹNI')),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 80,
                                child: _history(state.stake2History),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (state.showAnimation)
                      Expanded(
                        child: Center(
                          child: _ShuffleAnimation(
                            availableNumbers: [
                              ...state.stake1,
                              ...state.stake2
                            ],
                          ),
                        ),
                      ),
                    if (!state.showAnimation && state.mostRecent != null)
                      Expanded(
                        child: Center(
                          child: Text(
                            state.mostRecent.toString(),
                            style: const TextStyle(fontSize: 120),
                          ),
                        ),
                      ),
                    if (!state.showAnimation && state.mostRecent == null)
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Rozpocznij losowanie klikając przyciski poniżej',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: BlocBuilder<GeneratorCubit, GeneratorState>(
                  bloc: BlocProvider.of<GeneratorCubit>(context),
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: state.stake1.isEmpty
                              ? null
                              : () {
                                  BlocProvider.of<GeneratorCubit>(context)
                                      .drawStake1();
                                },
                          child: const Text('LOSUJ - KOBIETY'),
                        ),
                        ElevatedButton(
                          onPressed: state.stake2.isEmpty
                              ? null
                              : () {
                                  BlocProvider.of<GeneratorCubit>(context)
                                      .drawStake2();
                                },
                          child: const Text('LOSUJ - MĘŻCZYŹNI'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ListView _history(List<int> stake) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: stake.reversed.map((e) {
        return Center(
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black45,
                width: 3,
              ),
            ),
            child: Text(e.toString()),
          ),
        );
      }).toList(),
    );
  }
}

class _ShuffleAnimation extends StatefulWidget {
  const _ShuffleAnimation({
    required this.availableNumbers,
    Key? key,
  }) : super(key: key);

  final List<int> availableNumbers;

  @override
  State<_ShuffleAnimation> createState() => __ShuffleAnimationState();
}

class __ShuffleAnimationState extends State<_ShuffleAnimation> {
  late Stream<int> _numberStream;
  late int _currentNumber;

  @override
  void initState() {
    super.initState();

    _numberStream = _generateNumbers().asBroadcastStream();
    _currentNumber = widget.availableNumbers[0];
  }

  Stream<int> _generateNumbers() async* {
    final random = Random.secure();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield widget
          .availableNumbers[random.nextInt(widget.availableNumbers.length)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _numberStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _currentNumber = snapshot.data!;
        }
        return AnimatedFlipCounter(
          value: _currentNumber,
          duration: const Duration(milliseconds: 50),
          textStyle: const TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
          ),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _numberStream.drain();
  }
}
