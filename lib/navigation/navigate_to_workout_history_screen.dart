import 'package:fitness_app/dependency/dependency_provider.dart';
import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/workout_history/workout_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'abstract_navigation_state.dart';

class NavigateToWorkoutHistoryScreen extends AbstractNavigateToState {
  final List<Program> program;
  final Function(dynamic result)? onPop;

  NavigateToWorkoutHistoryScreen(
      {bool rootNavigator = true, this.onPop, required this.program})
      : super(rootNavigator: rootNavigator);

  @override
  call(context) {
    final page =
        WorkoutHistory(() => DProvider.of(context)!.blocSubModule.workBloc(),program);
    final route = createPageRoute(page);
    Navigator.of(context, rootNavigator: rootNavigator)
        .push(route)
        .then((value) {
      logPreviousPageName(context);
      return onPop?.call(value);
    });
    logOpenedPageName(context);
  }

  @override
  String getNavigationToScreenName() => "workout_history"; // DriverTipScreen
}
