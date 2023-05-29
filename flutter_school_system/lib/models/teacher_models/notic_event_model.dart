class NoticModel {
    String message;
    int code;
    List<Notic> data;

    NoticModel({
         this.message = "no-message",
         this.code = 0,
         this.data = const [],
    });

    factory NoticModel.fromJson(Map<String, dynamic> json) => NoticModel(
        message: json["message"],
        code: json["code"],
        data: List<Notic>.from(json["data"].map((x) => Notic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Notic {
    int id;
    String text;
    String file;
    DateTime createdAt;
    DateTime updatedAt;

    Notic({
         this.id = 0,
         this.text = "no-text",
         this.file = "no-file",
        required this.createdAt,
        required this.updatedAt,
    });

    factory Notic.fromJson(Map<String, dynamic> json) => Notic(
        id: json["id"],
        text: json["text"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
