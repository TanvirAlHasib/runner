class RunDetailsModel {

  RunDetailsModel({this.title = "Run", required this.distance, required this.pace, required this.dateTime});

  final String title;
  final double distance;
  final double pace;
  final DateTime dateTime;

  factory RunDetailsModel.fromMap(Map<String, dynamic> details) {
    return RunDetailsModel(
      title: details["title"],
      distance: details["distance"],
      pace: details["pace"],
      dateTime: details["dateTime"]
    );
  }
}