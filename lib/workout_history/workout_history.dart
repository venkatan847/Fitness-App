import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:fitness_app/workout/workout_event.dart';
import 'package:fitness_app/workout/workout_state.dart';
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
    return StreamBuilder(
        stream: bloc.getStreamOfType<WorkoutHistoryState>(),
        builder: (context, AsyncSnapshot<WorkoutHistoryState> snapshot) {
          if (snapshot.data == null) return Container();
          final data = snapshot.data!.program;
          return Scaffold(appBar: appBar(context), body: body(data));
        });
  }

  ListView body(List<Program> programData) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        itemCount: programData.length,
        itemBuilder: (context, index) {
          final data = programData[index];
          return Column(children: [
            const SizedBox(height: 20),
            programTitle(data),
            const SizedBox(height: 20),
            workout(data, context, index)
          ]);
        });
  }

  Card workout(Program data, BuildContext context, int index) {
    return Card(
        child: Column(
            children: data.workout
                .map((workout) => Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: 230,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.red, width: 1))),
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
                          const SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                editButton(context, workout),
                                const SizedBox(width: 15),
                                deleteButton(index, workout)
                              ])
                        ])))
                .toList()));
  }

  Widget deleteButton(int index, Workout workout) {
    return InkWell(
        onTap: () {
          bloc.event.add(DeleteWorkoutTapEvent('delete workout', workout));
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.red),
            child: const Text('Delete',
                style: TextStyle(color: Colors.white, fontSize: 20))));
  }

  Widget editButton(BuildContext context, Workout workout) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop(workout);
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.blue),
            child: const Text('Edit',
                style: TextStyle(color: Colors.white, fontSize: 20))));
  }

  Widget title(Program data) {
    return Text("Program Title:    ${data.title ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Widget recordedTime(Workout workout) {
    return Text("Recorded Time:    ${workout.recordedTime ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Widget weight(Workout workout) {
    return Text("Weight:    ${workout.weight ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Widget workoutTitle(Workout workout) {
    return Text("Program Title:    ${workout.title ?? ''}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }

  Widget programTitle(Program data) {
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
