import 'package:fitness_app/dependency/default_remote_configuration.dart';
import 'package:template_package/template_package.dart';

class CoreSubModule extends ISubModule {
  BaseAnalytics? _analytics;

  CoreSubModule() {}

  @override
  init(List<ISubModule> subModules) {}

  BaseAnalytics analytics() {
    _analytics ??= AnalyticsProxy([], enable: true);
    return _analytics!;
  }

  RemoteConfiguration remoteConfiguration() => DefaultRemoteConfig();
}
