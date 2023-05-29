class RegisterModel {
    String message;
    String statusCode;
    Info user;

    RegisterModel({
         this.message = "no-message",
         this.statusCode = "no-statusCode",
        required this.user,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        message: json["message"],
        statusCode: json["statusCode"],
        user: Info.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "user": user.toJson(),
    };
}

class Info {
    String fullname;
    String email;
    String phone;
    String studentId;
    String userClass;
    String roles;
    String session;
    int id;

    Info({
         this.fullname = "no-fullname",
         this.email = "no-email",
         this.phone = "no-phone",
         this.studentId = "no-studentId",
         this.userClass = "no-userClass",
         this.roles = "no-roles",
         this.session = "no-session",
         this.id = 0,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        studentId: json["student_id"],
        userClass: json["class"],
        roles: json["roles"],
        session: json["session"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "student_id": studentId,
        "class": userClass,
        "roles": roles,
        "session": session,
        "id": id,
    };
}
