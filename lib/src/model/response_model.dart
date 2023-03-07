class ResponseModel {
  final String activity;
  final String type;
  final String link;
  final int participants;
  final double accessibility;

  ResponseModel({
    required this.activity,
    required this.type,
    required this.link,
    required this.accessibility,
    required this.participants,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> data) {
    String? activity = data["activity"] as String?;
    String? type = data["type"] as String?;
    String? link = data["link"] as String?;
    int? participants = data["participants"] as int?;
    dynamic accessibility = data["accessibility"] as dynamic;
    return ResponseModel(
      activity: activity!,
      type: type!,
      link: link!,
      participants: participants ?? 0,
      accessibility: double.tryParse(accessibility.toString()) ?? 0,
    );
  }
}
