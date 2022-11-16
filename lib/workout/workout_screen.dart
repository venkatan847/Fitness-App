import 'dart:async';
import 'package:fitness_app/fitnessBlock/work_event.dart';
import 'package:fitness_app/fitnessBlock/work_state.dart';
import 'package:fitness_app/modal/program_class.dart';
import 'package:fitness_app/modal/workout_class.dart';
import 'package:flutter/material.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_package.dart';

class MyHomePage extends BaseWidget {
  MyHomePage(BaseBloc Function() getBloc, {super.key, required this.title})
      : super(getBloc);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage, BaseBloc> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getStreamOfType<ProgramState>(),
        builder: (context, AsyncSnapshot<ProgramState> snapshot) {
          if (snapshot.data == null) return Container();
          final data = snapshot.data!.program;
          return Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: ListView(
                  controller: scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  children: [
                    const Text('Select Program',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: data
                                .map((e) => Column(children: [
                                      programCard(e.title ?? '',
                                          e.imgPath ?? '', e.workout, e)
                                    ]))
                                .toList())),
                    const SizedBox(height: 20),
                    workout(),
                    const SizedBox(height: 20),
                    selectedWorkout()
                  ]));
        });
  }

  Widget programCard(String title, String imgPath, List<Workout> workoutList,
      Program program) {
    return InkWell(
        onTap: () {
          bloc.event.add(ProgramTapEvent('ProgramTapEvent', title));
        },
        child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 250,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color:
                        program.isSelect ? Colors.orange : Colors.transparent,
                    width: 2)),
            child: Column(children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(imgPath, fit: BoxFit.cover))),
              Center(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              const SizedBox(height: 4),
              Text('${workoutList.length} Program',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 2),
            ])));
  }

  Widget workoutCard(String title, String imgPath, Workout workout) {
    return InkWell(
        onTap: () {
          bloc.event.add(WorkoutTapEvent('WorkoutEvent', workout));
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
        },
        child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 130,
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(imgPath, fit: BoxFit.cover))),
            ])));
  }

  Widget workout() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<WorkoutState>(),
        builder: (context, AsyncSnapshot<WorkoutState> snapshot) {
          if (snapshot.data == null) return Container();
          return Row(
              children: snapshot.data!.workout
                  .map((e) => workoutCard(e.title ?? '', e.imgPath ?? '', e))
                  .toList());
        });
  }

  Widget displayCount() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<RecordState>(),
        builder: (context, AsyncSnapshot<RecordState> snapshot) {
          if (snapshot.data == null) return Container();
          return Text(snapshot.data!.count,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
        });
  }

  Widget startButton(Workout data) {
    return SizedBox(
        height: 54,
        width: 150,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            onPressed: () async {
              if (data.hasStarted) {
                bloc.event.add(StopWorkoutTapEvent('Stop workout', data));
              } else {
                bloc.event.add(StartWorkoutEvent('analytics', data));
              }
            },
            child: Text(data.hasStarted ? 'Stop' : 'Start',
                style: const TextStyle(fontSize: 20, letterSpacing: 0.7))));
  }

  Widget selectedWorkout() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<SelectedWorkoutState>(),
        builder: (context, AsyncSnapshot<SelectedWorkoutState> snapshot) {
          if (snapshot.data == null) return Container();
          final data = snapshot.data!.workout;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(data.title ?? '',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold))),
                      Column(children: [
                        Text(
                            ' Set Time: ${data.setTime?.toStringAsFixed(0) ?? 0.0} Minutes',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        if (data.hasStarted != true &&
                            data.recordedTime.isNotEmpty)
                          Text('Recorded time: ${data.recordedTime}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))
                      ])
                    ]),
                const SizedBox(height: 20),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(data.imgPath ?? '')),
                const SizedBox(height: 20),
                Center(child: startButton(data)),
                const SizedBox(height: 10),
                if (data.hasStarted) Center(child: displayCount()),
                const SizedBox(height: 20),
              ]);
        });
  }
}
