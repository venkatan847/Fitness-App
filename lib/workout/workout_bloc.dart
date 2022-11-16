import 'dart:async';
import 'dart:convert';
import 'package:base_bloc/bloc/event.dart';
import 'package:fitness_app/fitnessBlock/work_event.dart';
import 'package:fitness_app/fitnessBlock/work_state.dart';
import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_package/template_bloc/template_bloc.dart';

class WorkBloc extends TemplateBloc {
  BehaviorSubject programController = BehaviorSubject<ProgramState>();
  BehaviorSubject workoutController = BehaviorSubject<WorkoutState>();
  BehaviorSubject controller = BehaviorSubject<SelectedWorkoutState>();
  BehaviorSubject recordController = BehaviorSubject<RecordState>();
  Timer? timer;

  //   //Barbell row, Bench press, Shoulder press,Deadlift, Squat
  List<Program> programList = [
    Program("Barbell Row", "assets/program_images/barbell_row.jpeg", false, [
      Workout("Barbell Row", false, "0", false, 'assets/barbell_row.GIF', 5),
    ]),
    Program("Bench press", "assets/program_images/Bench_press.jpeg", false, [
      Workout("Bench Press", false, "0", false, 'assets/bench_press.GIF', 5),
    ]),
    Program("Shoulder", "assets/program_images/shoulder_press.jpeg", false, [
      Workout("Knee Shoulder Press", false, "0", false,
          'assets/knee_shoulder_press.GIF', 5),
      Workout("Stand Shoulder Press", false, "0", false,
          'assets/stand_shoulder_press.GIF', 5)
    ]),
    Program("DeadLift", "assets/program_images/deadLift.webp", false, [
      Workout("DeadLift", false, "0", false, 'assets/deadLift.gif', 5),
      Workout("kettlebell-Deadlift", false, "0", false,
          'assets/Kettlebell-Deadlift.gif', 5)
    ]),
    Program("Squat", "assets/program_images/squat.webp", false, [
      Workout("Stand Squat", false, "0", false, 'assets/stand_squat.GIF', 5),
      Workout("Seated Squat", false, "0", false, 'assets/seated_squat.GIF', 5),
    ]),
  ];

  WorkBloc(super.analytics) {
    registerStreams([
      programController.stream,
      workoutController.stream,
      recordController.stream,
      controller.stream
    ]);
    init();
  }

  void init() {
    initialise();
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is ProgramTapEvent) {
      program(event);
    } else if (event is WorkoutTapEvent) {
      workout(event);
    } else if (event is StartWorkoutEvent) {
      startWorkout(event);
    } else if (event is StopWorkoutTapEvent) {
      stopWorkout(event);
    }
  }

  void program(ProgramTapEvent event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Program> program = await workoutData();
    for (var element in program) {
      if (element.title == event.title) {
        element.isSelect = true;
        workoutController.sink.add(WorkoutState(element.workout));
      } else {
        element.isSelect = false;
      }
    }
    prefs.setString('WorkoutData', jsonEncode(program));
    programController.sink.add(ProgramState(program));
  }

  void workout(WorkoutTapEvent event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Program> program = await workoutData();
    for (var element in program) {
      for (var workout in element.workout) {
        if (workout.title == event.workout.title) {
          workout.isSelect = true;
          controller.sink.add(SelectedWorkoutState(workout));
        } else {
          workout.isSelect = false;
        }
      }
    }
    prefs.setString('WorkoutData', jsonEncode(program));
  }

  startWorkout(StartWorkoutEvent event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Program> program = await workoutData();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      recordController.sink
          .add(RecordState(event.workout, getDifference(prefs)));
    });
    for (var element in program) {
      for (var workout in element.workout) {
        if (workout.hasStarted) {
          for (var element in program) {
            for (var workout in element.workout) {
              if (workout.title == event.workout.title) {
                if (workout.recordedTime != '0') {
                  workout.recordedTime =
                      addTime(workout.recordedTime, getDifference(prefs));
                } else {
                  workout.recordedTime = getDifference(prefs);
                }
              }
              workout.hasStarted = false;
            }
          }
        }
        if (workout.title == event.workout.title) {
          workout.hasStarted = true;
          controller.sink.add(SelectedWorkoutState(workout));
        } else {
          workout.hasStarted = false;
        }
      }
    }
    prefs.setString("Start", "${DateTime.now()}");
    prefs.setString('WorkoutData', jsonEncode(program));
  }

  String getDifference(SharedPreferences prefs) {
    final time = DateTime.now()
        .difference(DateTime.parse("${prefs.getString("Start")}"))
        .toString()
        .split(':');
    return "${time[0]} : ${time[1]} : ${time[2].substring(0, 2)}";
  }

  void stopWorkout(StopWorkoutTapEvent event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Program> program = await workoutData();
    for (var element in program) {
      for (var workout in element.workout) {
        if (workout.title == event.workout.title) {
          if (workout.recordedTime != '0') {
            workout.recordedTime =
                addTime(workout.recordedTime, getDifference(prefs));
          } else {
            workout.recordedTime = getDifference(prefs);
          }
          workout.hasStarted = false;
          controller.sink.add(SelectedWorkoutState(workout));
          recordController.sink.add(RecordState(event.workout, ''));
        }
      }
    }
    prefs.setString('WorkoutData', jsonEncode(program));
    timer?.cancel();
  }

  Future<List<Program>> workoutData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Program> program = [];
    if (prefs.getString('WorkoutData') != null) {
      List<dynamic> data = jsonDecode(prefs.getString('WorkoutData') ?? '');
      for (var element in data) {
        program.add(Program.fromJson(element));
      }
    }
    return program;
  }

  initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Program> program = [];
    if (prefs.getString('WorkoutData') != null) {
      List<dynamic> data = jsonDecode(prefs.getString('WorkoutData') ?? '');
      for (var element in data) {
        program.add(Program.fromJson(element));
      }
    } else {
      program = programList;
    }
    prefs.setString('WorkoutData', jsonEncode(program));
    programController.sink.add(ProgramState(program));
  }

  String addTime(String recordedTime, String difference) {
    final oldValue = recordedTime.split(':');
    final newValue = difference.split(":");
    int seconds = int.parse(oldValue[2]) + int.parse(newValue[2]);
    int minutes = int.parse(oldValue[1]) + int.parse(newValue[1]);
    int hours = int.parse(oldValue[0]) + int.parse(newValue[0]);
    if (seconds > 60) {
      final newSeconds = "${seconds / 60}";
      minutes = minutes + int.parse(newSeconds.split(".")[0]);
      seconds = int.parse(newSeconds.split(".")[1]);
    }
    if (minutes > 60) {
      final newMinutes = "${minutes / 60}";
      hours = hours + int.parse(newMinutes.split(".")[0]);
      minutes = int.parse(newMinutes.split(".")[1]);
    }
    return "$hours : $minutes : $seconds";
  }

  @override
  dispose() {
    programController.close();
    workoutController.close();
    controller.close();
    timer?.cancel();
    return super.dispose();
  }
}
