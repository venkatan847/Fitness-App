import 'package:fitness_app/workout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';
import 'dependency/dependency_provider.dart';

class MyApp extends StatelessWidget {
  final List<ISubModule> subModules;

  MyApp(this.subModules, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WorkoutScreen(() => DProvider.of(context)!.blocSubModule.workBloc(),
          title: 'Fitness App'),
    );
  }
}
