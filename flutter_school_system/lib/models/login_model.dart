import 'package:equatable/equatable.dart';

class LoginModel {
  String code;
  String message;
  Data data;

  LoginModel({
    this.code = "no-code",
    this.message = "no-message",
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String tokenType;
  String accessToken;
  User user;

  Data({
    this.tokenType = "no-tokenType",
    this.accessToken = "no-accessToken",
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class User extends Equatable {
  int id;
  String fullname;
  String phone;
  String studentId;
  String userClass;
  String session;
  String roles;
  String image;
  String email;
  String? emailVerifiedAt;

  User({
    this.id = 0,
    this.fullname = "no-fullname",
    this.phone = "no-phone",
    this.studentId = "no-studentId",
    this.userClass = "no-userClass",
    this.session = "no-session",
    this.roles = "no-roles",
    this.email = "no-email",
    this.image = "no-image",
    this.emailVerifiedAt = "no-emailVerifiedAt",
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        phone: json["phone"],
        studentId: json["student_id"],
        userClass: json["class"],
        session: json["session"],
        roles: json["roles"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] ?? " ",
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "student_id": studentId,
        "class": userClass,
        "session": session,
        "roles": roles,
        "email": email,
        "email_verified_at": emailVerifiedAt ?? "",
      };

  @override
  List<Object?> get props => [roles];
}
