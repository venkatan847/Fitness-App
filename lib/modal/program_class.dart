import 'package:fitness_app/modal/workout_class.dart';

class Program {
  final String? title;
  final String? imgPath;
   bool isSelect = false;
  final List<Workout> workout;

  Program(this.title, this.imgPath, this.isSelect, this.workout);

  Program.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imgPath = json['imgPath'],
        isSelect = json['isSelect'],
        workout = json['workout'];

  Map toJson() =>
      {
        'title': title,
        'imgPath': imgPath,
        'isSelect': isSelect,
        'workout': workout
      };
}
