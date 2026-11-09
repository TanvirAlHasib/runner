class RunDetailsModel {

  RunDetailsModel({this.title = "Run", required this.distance, required this.pace,
    required this.dateTime, this.duration = 0});

  final String title;
  final double distance;
  final double pace;
  final DateTime dateTime;
  final int? duration;

  factory RunDetailsModel.fromMap(Map<String, dynamic> details) {
    return RunDetailsModel(
      title: details["title"],
      distance: details["distance"],
      pace: details["pace"],
      dateTime: details["dateTime"],
      duration: details["duration"]
    );
  }
}