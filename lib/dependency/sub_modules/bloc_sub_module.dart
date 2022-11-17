import 'package:fitness_app/workout/workout_bloc.dart';
import 'package:template_package/template_package.dart';
import 'core_sub_modules.dart';

class BlocSubModule extends ISubModule {
  late CoreSubModule _coreSubModule;

  @override
  init(List<ISubModule> subModules) {
    _coreSubModule = subModules
        .singleWhere((element) => element is CoreSubModule) as CoreSubModule;
  }

  WorkoutBloc workBloc() {
    return WorkoutBloc(_coreSubModule.analytics());
  }
}
