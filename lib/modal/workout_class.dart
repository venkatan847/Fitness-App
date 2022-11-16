class Workout {
  final String? title;
  final bool? hasStarted;
  final String? recordedTime;
  bool isSelect = false;
  final String? imgPath;
  final double? setTime;

  Workout(this.title, this.hasStarted, this.recordedTime, this.isSelect,
      this.imgPath, this.setTime);

  Workout.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        hasStarted = json['hasStarted'],
        recordedTime = json['recordedTime'],
        isSelect = json['isSelect'],
        imgPath = json['imgPath'],
        setTime = json['setTime'];

  Map toJson() => {
        'title': title,
        'hasStarted': hasStarted,
        'recordedTime': recordedTime,
        'isSelect': isSelect,
        'imgPath': imgPath,
        'setTime': setTime
      };
}
