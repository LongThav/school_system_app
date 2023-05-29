import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/models/login_model.dart';


class SecureHelperLogin {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String token = 'token';
  final String noData = "no-Data";
  final String user = 'user';
  final String roles = '';
  final String noRoles = 'noRoles';

  void writeUserLogin(String value) {
    _secureStorage.write(key: user, value: value);
  }

  void writeToken(String value) {
    _secureStorage.write(key: token, value: value);
  }

  void wrtieRole(String value) {
    _secureStorage.write(key: roles, value: value);
  }

  Future<String> readRole() async {
    String? role = await _secureStorage.read(key: roles);
    return role ?? noRoles;
  }

  Future<String> readUserInfor() async {
    String? userInfo = await _secureStorage.read(key: user);
    return userInfo ?? noData;
  }

  Future<List<dynamic>> readUserLogin() async {
    String? userToken = await _secureStorage.read(key: token);
    List infoUser = [];
    infoUser.add(userToken);

    final user = LoginModel(data: Data(user: User()));
    infoUser.add(user);

    return infoUser;
  }

  void deleteLocalUserLogin() {
    _secureStorage.deleteAll();
  }

  void clearKeyToken(BuildContext context) {
    _secureStorage.deleteAll();
  }
}
