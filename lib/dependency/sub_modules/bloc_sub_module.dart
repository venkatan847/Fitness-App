import 'package:fitness_app/fitnessBlock/work_bloc.dart';
import 'package:template_package/template_package.dart';
import 'core_sub_modules.dart';
import 'ebr_sub_module.dart';

class BlocSubModule extends ISubModule {
  late CoreSubModule _coreSubModule;
  late EBRSubModule _ebrSubmodule;

  @override
  init(List<ISubModule> subModules) {
    _coreSubModule = subModules
        .singleWhere((element) => element is CoreSubModule) as CoreSubModule;
    _ebrSubmodule = subModules.singleWhere((element) => element is EBRSubModule)
        as EBRSubModule;
  }

  WorkBloc workBloc() {
    return WorkBloc(_coreSubModule.analytics());
  }
}
