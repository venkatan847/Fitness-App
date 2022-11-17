import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:template_package/template_package.dart';

class ProgramState extends BaseBlocDataState {
  List<Program> program;

  ProgramState(this.program);
}

class WorkoutState extends BaseBlocDataState {
  List<Workout> workout;

  WorkoutState(this.workout);
}

class SelectedWorkoutState extends BaseBlocDataState {
  final Workout workout;

  SelectedWorkoutState(this.workout);
}

class RecordState extends BaseBlocDataState {
  final Workout workout;
  final String count;

  RecordState(this.workout, this.count);
}

class SuggestSetState extends BaseBlocDataState {
  final int numberOfSets;

  SuggestSetState(this.numberOfSets);
}

class WorkoutHistoryState extends BaseBlocDataState {
  List<Program> program;

  WorkoutHistoryState(this.program);
}
