import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:template_package/template_package.dart';

class ClockInState extends BaseBlocDataState {
  final String clockIn;

  ClockInState(this.clockIn);
}

class DisplayCountState extends BaseBlocDataState {
  final String count;

  DisplayCountState(this.count);
}

class StartState extends BaseBlocDataState {
  final bool start;

  StartState(this.start);
}

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
