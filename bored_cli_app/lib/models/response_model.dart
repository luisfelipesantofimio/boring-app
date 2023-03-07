class ResponseModel {
  final String activity;
  final String type;
  final String link;
  final dynamic accessibility;

  ResponseModel({
    required this.activity,
    required this.type,
    required this.link,
    required this.accessibility,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> data) {
    String? activity = data["activity"] as String?;
    String? type = data["type"] as String?;
    String? link = data["link"] as String?;
    dynamic accessibility = data["accessibility"] as dynamic;
    return ResponseModel(
      link: link!,
      activity: activity!,
      type: type!,
      accessibility: accessibility!,
    );
  }
}
