class RoleModel {
  String message;
  List<DataRole> dataRole;

  RoleModel({
    this.message = "no-message",
    this.dataRole = const [],
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        message: json["message"],
        dataRole: List<DataRole>.from(json["dataRole"].map((x) => DataRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "dataRole": List<dynamic>.from(dataRole.map((x) => x.toJson())),
      };
}

class DataRole {
  int id;
  String role;

  DataRole({
    this.id = 0,
    this.role = "no-role",
  });

  factory DataRole.fromJson(Map<String, dynamic> json) => DataRole(
        id: json["id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      };
}
