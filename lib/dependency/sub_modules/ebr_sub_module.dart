import 'package:template_package/template_package.dart';
import 'bloc_sub_module.dart';
import 'core_sub_modules.dart';

class EBRSubModule implements ISubModule {
  CoreSubModule? _coreSubModule;
  BlocSubModule? _blocSubModule;

  @override
  init(List<ISubModule> subModules) {
    _coreSubModule = subModules.whereType<CoreSubModule>().first;
    _blocSubModule = subModules.whereType<BlocSubModule>().first;
  }
}
