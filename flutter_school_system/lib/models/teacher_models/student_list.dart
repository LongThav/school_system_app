class StudentList {
    String message;
    String code;
    Data data;

    StudentList({
         this.message = "no-message",
         this.code = "no-code",
         required this.data,
    });

    factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        message: json["message"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": data.toJson(),
    };
}

class Data {
    List<User> user;

    Data({
         this.user = const [],
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
    };
}

class User {
    int id;
    String fullname;
    String phone;
    String studentId;
    String userClass;
    String session;
    String roles;
    String image;
    String email;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        this.id = 0,
        this.fullname = "no-fullname",
        this.phone = "no-phone",
        this.studentId = "no-studentId",
        this.userClass = "no-userClass",
        this.session = "no-session",
        this.roles = "no-roles",
        this.image = "no-image",
        this.email = "no-email",
       required this.createdAt,
       required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        phone: json["phone"],
        studentId: json["student_id"],
        userClass: json["class"],
        session: json["session"],
        roles: json["roles"],
        image: json["image"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "student_id": studentId,
        "class": userClass,
        "session": session,
        "roles": roles,
        "image": image,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
