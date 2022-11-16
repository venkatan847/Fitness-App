import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

import 'app.dart';
import 'dependency/dependency_module.dart';
import 'dependency/dependency_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencyModule = DependencyModule();
  List<ISubModule> subModules = dependencyModule.getReadySubModules();
  final appWidget = MyApp(subModules);
  DProvider appWithDependencies = DProvider(subModules, child: appWidget);
  runApp(appWithDependencies);
}



