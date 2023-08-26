import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/injectable_container.dart';
import 'provider/generator_cubit.dart';
import 'routes/drawing.dart';
import 'routes/home.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GeneratorCubit>()..init(),
      child: MaterialApp(
        title: 'Generator',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: {
          '/': (context) => const HomePage(),
          Drawing.pageName: (context) => const Drawing(),
        },
      ),
    );
  }
}
