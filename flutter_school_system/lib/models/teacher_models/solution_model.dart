class SolutionModel {
    String message;
    int code;
    List<Solution> data;

    SolutionModel({
         this.message = "no-message",
         this.code = 0,
         this.data = const [],
    });

    factory SolutionModel.fromJson(Map<String, dynamic> json) => SolutionModel(
        message: json["message"],
        code: json["code"],
        data: List<Solution>.from(json["data"].map((x) => Solution.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Solution {
    int id;
    String text;
    String file;
    DateTime createdAt;
    DateTime updatedAt;

    Solution({
         this.id = 0,
         this.text = "no-text",
         this.file = "no-file",
        required this.createdAt,
        required this.updatedAt,
    });

    factory Solution.fromJson(Map<String, dynamic> json) => Solution(
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
