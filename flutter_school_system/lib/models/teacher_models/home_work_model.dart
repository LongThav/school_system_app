class HomeWorkModel {
    String message;
    List<HomeWork> data;

    HomeWorkModel({
         this.message = "no-message",
         this.data = const [],
    });

    factory HomeWorkModel.fromJson(Map<String, dynamic> json) => HomeWorkModel(
        message: json["message"],
        data: List<HomeWork>.from(json["data"].map((x) => HomeWork.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HomeWork {
    int id;
    String text;
    String file;
    DateTime createdAt;
    DateTime updatedAt;

    HomeWork({
         this.id = 0,
         this.text = "no-text",
         this.file = "no-file",
         required this.createdAt,
         required this.updatedAt,
    });

    factory HomeWork.fromJson(Map<String, dynamic> json) => HomeWork(
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
