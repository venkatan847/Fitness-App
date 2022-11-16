import 'dart:async';
import 'package:flutter/material.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_package.dart';
import 'dependency/dependency_module.dart';
import 'dependency/dependency_provider.dart';
import 'fitnessBlock/work_event.dart';
import 'fitnessBlock/work_state.dart';
import 'modal/workout_class.dart';
import 'package:fitness_app/modal/program_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencyModule = DependencyModule();
  List<ISubModule> subModules = dependencyModule.getReadySubModules();
  final appWidget = MyApp(subModules);
  DProvider appWithDependencies = DProvider(subModules, child: appWidget);
  runApp(appWithDependencies);
}



