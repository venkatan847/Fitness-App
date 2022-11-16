import 'package:template_package/template_package.dart';
import 'core_sub_modules.dart';

class RepositorySubModule extends ISubModule {
  late CoreSubModule _coreSubModule;

  @override
  init(List<ISubModule> subModules) {
    _coreSubModule = subModules
        .singleWhere((element) => element is CoreSubModule) as CoreSubModule;
  }

}
