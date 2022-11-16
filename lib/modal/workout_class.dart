class Workout {
  final String? title;
  bool hasStarted = false;
  String recordedTime = '';
  bool isSelect = false;
  final String? imgPath;
  int? weight = 0;
  final double? setTime;

  Workout(this.title, this.hasStarted, this.recordedTime, this.isSelect,
      this.imgPath, this.weight, this.setTime);

  Workout.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        hasStarted = json['hasStarted'],
        recordedTime = json['recordedTime'],
        isSelect = json['isSelect'],
        imgPath = json['imgPath'],
        weight = json['weight'],
        setTime = json['setTime'];

  Map toJson() => {
        'title': title,
        'hasStarted': hasStarted,
        'recordedTime': recordedTime,
        'isSelect': isSelect,
        'imgPath': imgPath,
        'weight': weight,
        'setTime': setTime
      };
}
