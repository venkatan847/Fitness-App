import 'package:fitness_app/dependency/dependency_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:template_package/template_package.dart';

abstract class AbstractNavigateToState extends BaseBlocPrimaryState {
  final bool rootNavigator;

  AbstractNavigateToState({required this.rootNavigator});

  @override
  call(context) {
    logOpenedPageName(context);
  }

  /// Logs the opening page name to the provided analytics
  logOpenedPageName(BuildContext context) {
    _getAnalytics(context)!.logPageName(getNavigationToScreenName(), []);
  }

  /// Uses the ModalRoute of context to
  /// provide the previous route screen name and log the analytics
  logPreviousPageName(BuildContext param) {
    final previousScreenName =
        ModalRoute.of(param)?.settings?.name ?? 'unknown_or_root';
    _getAnalytics(param)!.logPageName(previousScreenName, []);
  }

  BaseAnalytics? _getAnalytics(BuildContext context) {
    return DProvider.of(context)!.coreSubModule.analytics();
  }

  /// Creates a default route with routeSettings.name of the current screen
  PageRoute createPageRoute(Widget page) {
    return CupertinoPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: getNavigationToScreenName()));
  }

  String getNavigationToScreenName();
}
