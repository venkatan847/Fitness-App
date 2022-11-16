import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:flutter/material.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_package.dart';

class WorkoutHistory extends BaseWidget {
  final List<Program> program;

  WorkoutHistory(BaseBloc Function() getBloc, this.program, {Key? key})
      : super(getBloc, key: key);

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends BaseState<WorkoutHistory, BaseBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context), body: body());
  }

  ListView body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        itemCount: widget.program.length,
        itemBuilder: (context, index) {
          final data = widget.program[index];
          return Column(children: [
            const SizedBox(height: 20),
            programTitle(data),
            const SizedBox(height: 20),
            workout(data, context)
          ]);
        });
  }

  Card workout(Program data, BuildContext context) {
    return Card(
        child: Column(
            children: data.workout
                .map((workout) => InkWell(
                    onTap: () {
                      Navigator.of(context).pop(workout);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.red, width: 1))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              workoutTitle(workout),
                              const SizedBox(height: 8),
                              weight(workout),
                              const SizedBox(height: 8),
                              recordedTime(workout),
                              const SizedBox(height: 8),
                              title(data),
                              const SizedBox(height: 8)
                            ]))))
                .toList()));
  }

  Widget title(Program data) {
    return Text("Program Title:    ${data.title ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Text recordedTime(Workout workout) {
    return Text("Recorded Time:    ${workout.recordedTime ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Text weight(Workout workout) {
    return Text("Weight:    ${workout.weight ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Text workoutTitle(Workout workout) {
    return Text("Program Title:    ${workout.title ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Text programTitle(Program data) {
    return Text(data.title ?? '',
        style: const TextStyle(
            color: Colors.red,
            letterSpacing: .1,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        title: const Text('Workout History'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_rounded)));
  }
}
