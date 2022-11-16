import 'package:dependency_provider/base_sub_module.dart';
import 'package:dependency_provider/dependency_module/dependency_module.dart';
import 'package:fitness_app/dependency/sub_modules/bloc_sub_module.dart';
import 'package:fitness_app/dependency/sub_modules/core_sub_modules.dart';
import 'package:fitness_app/dependency/sub_modules/repostory_sub_module.dart';
import 'package:flutter/material.dart';

///CRUCIAL IMPORTANCE THIS CLASS MUST BE INITIALIZED IN MAIN ONLY ONE TIME
///if you need any object use [DProvider] which has access to this [subModules]
class DependencyModule extends BaseDependencyModule {
  DependencyModule();
  @protected
  @override
  List<ISubModule> createSubmodules() {
    return [
      CoreSubModule(),
      BlocSubModule(),
    ];
  }
}
