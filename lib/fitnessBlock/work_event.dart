import 'package:fitness_app/modal/workout_class.dart';
import 'package:template_package/template_package.dart';
import 'package:fitness_app/modal/program_class.dart';

class ClockInTapEvent extends BaseBlocEvent {
  final String clockIn;

  ClockInTapEvent(super.analyticEventName, this.clockIn);
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
