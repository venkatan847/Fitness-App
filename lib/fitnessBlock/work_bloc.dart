import 'dart:convert';
import 'package:base_bloc/bloc/event.dart';
import 'package:fitness_app/fitnessBlock/work_event.dart';
import 'package:fitness_app/fitnessBlock/work_state.dart';
import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_package/template_bloc/template_bloc.dart';

class WorkBloc extends TemplateBloc {
  BehaviorSubject workController = BehaviorSubject<ClockInState>();
  BehaviorSubject countController = BehaviorSubject<DisplayCountState>();
  BehaviorSubject programController = BehaviorSubject<ProgramState>();
  BehaviorSubject workoutController = BehaviorSubject<WorkoutState>();
  BehaviorSubject controller = BehaviorSubject<SelectedWorkoutState>();

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
      workController.stream,
      countController.stream,
      programController.stream,
      workoutController.stream,
      controller.stream
    ]);
    init();
  }

  void init() {
    programController.sink.add(ProgramState(programList));
    initialiseClockIn();
    getWorkListInitialise();
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is ClockInTapEvent) {
      clockIn(event);
    } else if (event is ClockOutTapEvent) {
      if (event.hours.isNotEmpty) {
        clockOut(event);
      }
    } else if (event is WorkoutTapEvent) {
      programList.forEach((element) {
        element.workout.forEach((workout) {
          if (workout.title == event.workout.title) {
            workout.isSelect = true;
            controller.sink.add(SelectedWorkoutState(workout));
          } else {
            workout.isSelect = false;
          }
        });
      });
    } else if (event is ProgramTapEvent) {
      programList.forEach((element) {
        if (element.title == event.title) {
          element.isSelect = true;
          workoutController.sink.add(WorkoutState(element.workout));
        } else {
          element.isSelect = false;
        }
      });
      programController.sink.add(ProgramState(programList));
    } else if (event is StartEvent) {
      programController.sink.add(StartState(event.start));
    } else if (event is GetClockInTime) {
      countController.sink.add(DisplayCountState(event.clockIn));
    }
    // TODO: implemeddsad onUiDataChange
  }

  clockIn(ClockInTapEvent event) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString("ClockIn") != null) {
    //   prefs.remove("ClockIn");
    // }
    // prefs.setString("ClockIn", event.clockIn);
    workController.sink.add(ClockInState(event.clockIn));
  }

  initialiseClockIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("ClockIn") != null) {
      workController.sink.add(ClockInState("${prefs.getString("ClockIn")}"));
    }
  }

  void clockOut(ClockOutTapEvent event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("ClockIn") != null) {
      String clockIn = prefs.getString("ClockIn") ?? '';
      prefs.remove("ClockIn");

      // List<WorkClass> workList = [];
      if (prefs.getString('WorkList') != null) {
        List<dynamic> data = jsonDecode(prefs.getString('WorkList') ?? '');
        for (var element in data) {
          // workList.add(WorkClass.fromJson(element));
        }
      }
      //workList.add(WorkClass(clockIn, DateTime.now().toString(), event.hours));

      // prefs.setString('WorkList', jsonEncode(workList));
      workController.sink.add(ClockInState(""));
    }
  }

  getWorkListInitialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // if (prefs.getString('WorkList') != null) {
  }

  @override
  dispose() {
    workController.close();
    countController.close();
    programController.close();
    workoutController.close();
    controller.close();
    return super.dispose();
  }
}
