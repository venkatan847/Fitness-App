class MyApp extends StatelessWidget {
  final List<ISubModule> subModules;

  MyApp(this.subModules, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fitness App,
        theme: ThemeData(primarySwatch: Colors.blue),
    home: MyHomePage(() => DProvider.of(context)!.blocSubModule.workBloc(),
    title: 'Fitness App'),
    );
  }
}