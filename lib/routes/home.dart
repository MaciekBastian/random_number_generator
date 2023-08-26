import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../provider/generator_cubit.dart';
import 'drawing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GeneratorCubit, GeneratorState>(
        bloc: BlocProvider.of<GeneratorCubit>(context),
        builder: (context, state) {
          if (state.stake1.isEmpty || state.stake2.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(),
                  Column(
                    children: [
                      const Text('KOBIETY'),
                      const SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          state.stake1.join(', '),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(),
                  Column(
                    children: [
                      const Text('MĘŻCZYŹNI'),
                      const SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          state.stake2.join(', '),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Drawing.pageName);
                  },
                  child: const Text('AKCEPTUJ'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
