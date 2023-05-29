class SessionModel {
  String message;
  List<Section> data;

  SessionModel({
    this.message = "no-message",
    this.data = const [],
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        message: json["message"],
        data: List<Section>.from(json["data"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Section {
  int id;
  String session;

  Section({
    this.id = 0,
    this.session = "no-session",
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session": session,
      };
}
