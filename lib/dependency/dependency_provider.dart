import 'package:dependency_provider/base_sub_module.dart';
import 'package:fitness_app/dependency/sub_modules/bloc_sub_module.dart';
import 'package:fitness_app/dependency/sub_modules/core_sub_modules.dart';
import 'package:fitness_app/dependency/sub_modules/ebr_sub_module.dart';
import 'package:fitness_app/dependency/sub_modules/repostory_sub_module.dart';
import 'package:flutter/cupertino.dart';

class DProvider extends InheritedWidget {
  final List<ISubModule> _subModuleList;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  ///Must be initialized only on the top of the widget three (Should Be The App Parent)
  const DProvider(this._subModuleList, {super.key, required Widget child})
      : super(child: child);

  static DProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DProvider>();

  ///Bloc SUBMODULE
  BlocSubModule get blocSubModule =>
      _subModuleList.whereType<BlocSubModule>().first;

  //Repository SUBMODULE
  RepositorySubModule get repositorySubModule =>
      _subModuleList.whereType<RepositorySubModule>().first;

// EBR SUBMODULE
  EBRSubModule get ebrSubModule =>
      _subModuleList.whereType<EBRSubModule>().first;

  // Core SUBMODULE
  CoreSubModule get coreSubModule =>
      _subModuleList.whereType<CoreSubModule>().first;
}
