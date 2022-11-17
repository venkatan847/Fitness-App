import 'package:fitness_app/modal/workout_class.dart';
import 'package:template_package/template_package.dart';

class StartWorkoutEvent extends BaseBlocEvent {
  final Workout workout;

  StartWorkoutEvent(super.analyticEventName, this.workout);
}

class ClockOutTapEvent extends BaseBlocEvent {
  final String hours;

  ClockOutTapEvent(super.analyticEventName, this.hours);
}

class GetClockInTime extends BaseBlocEvent {
  final String clockIn;

  GetClockInTime(super.analyticEventName, this.clockIn);
}

class StartEvent extends BaseBlocEvent {
  final bool start;

  StartEvent(super.analyticEventName, this.start);
}

class WorkoutTapEvent extends BaseBlocEvent {
  final Workout workout;

  WorkoutTapEvent(super.analyticEventName, this.workout);
}

class ProgramTapEvent extends BaseBlocEvent {
  final String title;

  ProgramTapEvent(super.analyticEventName, this.title);
}

class StopWorkoutTapEvent extends BaseBlocEvent {
  final Workout workout;

  StopWorkoutTapEvent(super.analyticEventName, this.workout);
}

class SelectWeightTapEvent extends BaseBlocEvent {
  final int weight;
  final Workout workout;

  SelectWeightTapEvent(super.analyticEventName, this.weight, this.workout);
}

class WorkoutHistoryTapEvent extends BaseBlocEvent {
  WorkoutHistoryTapEvent(super.analyticEventName);
}

class DeleteWorkoutTapEvent extends BaseBlocEvent {
  final Workout workout;

  DeleteWorkoutTapEvent(super.analyticEventName, this.workout);
}
