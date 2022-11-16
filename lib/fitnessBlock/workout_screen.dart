class MyHomePage extends BaseWidget {
  MyHomePage(BaseBloc Function() getBloc, {super.key, required this.title})
      : super(getBloc);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage, BaseBloc> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getStreamOfType<ProgramState>(),
        builder: (context, AsyncSnapshot<ProgramState> snapshot) {
          if (snapshot.data == null) return Container();
          return Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: ListView(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  children: [
                    const Text('Select Program',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: snapshot.data!.program
                                .map((e) =>
                                programCard(e.title ?? '',
                                    e.imgPath ?? '', e.workout ?? [], e))
                                .toList())),
                    SizedBox(height: 20),
                    workout(),
                    SizedBox(height: 20),
                    selectedWorkout()
                  ]));
        });
  }

  Widget programCard(String title, String imgPath, List<Workout> workoutList,
      Program program) {
    return InkWell(
        onTap: () {
          // bloc.event.add(WorkoutEvent('WorkoutEvent', workoutList));
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
              SizedBox(height: 4),
              Text('${workoutList.length} Program',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(height: 2),
            ])));
  }

  Widget workoutCard(String title, String imgPath, Workout workout) {
    return InkWell(
        onTap: () {
          bloc.event.add(WorkoutTapEvent('WorkoutEvent', workout));
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

  Widget clockIn() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<ClockInState>(),
        builder: (context, AsyncSnapshot<ClockInState> snapshot) {
          if (snapshot.data == null || snapshot.data!.clockIn.isEmpty) {
            return Container();
          }
          getCount(snapshot.data!.clockIn);
          return Column(children: [
            const SizedBox(height: 30),
            displayCount(),
            const SizedBox(height: 30)
          ]);
        });
  }

  Widget displayCount() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<DisplayCountState>(),
        builder: (context, AsyncSnapshot<DisplayCountState> snapshot) {
          if (snapshot.data == null) return Container();
          // count = snapshot.data!.count;
          return Text(snapshot.data!.count,
              style:
              const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
        });
  }

  getCount(String clockIn) {
    try {
      List<String> time = [];
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (mounted) {
          time = DateTime.now()
              .difference(DateTime.parse(clockIn))
              .toString()
              .split(':');
          bloc.event.add(GetClockInTime('analytics',
              "${time[0]} : ${time[1]} : ${time[2].substring(0, 2)}"));
        }
      });
    } catch (e) {}
  }

  Widget StartButton(bool hasStarted) {
    return SizedBox(
        height: 54,
        width: 150,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            onPressed: () async {
              bloc.event.add(ClockInTapEvent('analytics', "${DateTime.now()}"));
            },
            child: Text(hasStarted ? 'Stop' : 'Start',
                style: TextStyle(fontSize: 20, letterSpacing: 0.7))));
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
                      Text(data.title ?? '',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(
                          ' Set Time: ${data?.setTime?.toStringAsFixed(0) ??
                              0.0} Minutes',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ]),
                SizedBox(height: 20),
                Image.asset(data.imgPath ?? ''),
                SizedBox(height: 20),
                Center(child: StartButton(data.hasStarted ?? false)),
                SizedBox(height: 10),
                displayCount(),
              ]);
        });
  }
}
