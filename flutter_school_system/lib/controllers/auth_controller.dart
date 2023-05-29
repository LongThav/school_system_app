import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/logger.dart';
import '../db_helper/secure_helper/secure_helper_login.dart';
import '../models/login_model.dart';
import '../views/login_view.dart';
import '../views/students/home_view_student.dart';
import '../views/teachers/home_view_teacher.dart';
import '../constants/loading_status.dart';
import '../constants/url_base.dart';
import '../models/register_model.dart';

class AuthController extends ChangeNotifier {
  final RegisterModel _registerModel = RegisterModel(user: Info());
  RegisterModel get registeModel => _registerModel;

  LoginModel _loginModel = LoginModel(data: Data(user: User()));
  LoginModel get loginModel => _loginModel;

  LoginModel _localLogin = LoginModel(data: Data(user: User()));
  LoginModel get localLogin => _localLogin;

  LoadingStatus _loadingStatus = LoadingStatus.none;
  LoadingStatus get loadingstatus => _loadingStatus;

  LoadingStatus _createUserLoading = LoadingStatus.none;
  LoadingStatus get createUserLoading => _createUserLoading;

  void setCreateUserLoading() {
    _createUserLoading = LoadingStatus.loading;
    notifyListeners();
  }

  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();
  }

  final SecureHelperLogin _secureHelperLogin = SecureHelperLogin();

  Future<bool> createUser(
      String fullname,
      String phone,
      String password,
      String email,
      String studentId,
      String classUser,
      String session,
      String roles,
      BuildContext context) async {
    try {
      final Map<String, dynamic> body = {
        'fullname': fullname,
        'phone': phone,
        'password': password,
        'email': email,
        'student_id': studentId,
        'class': classUser,
        'session': session,
        'roles': roles
      };
      'Map: $body'.log();
      String url = mainUrl + register;
      'Url: $url'.log();
      http.Response response = await http.post(Uri.parse(url), body: body);
      'Respone: ${response.body}'.log();
      if (response.statusCode == 200) {
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const LoginView();
          }), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Created user successfully')));
        });
        return true;
      } else {
        'Other error'.log();
        return false;
      }
    } catch (error) {
      'Respone Error: $error'.log();
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> loginController(
      String password, String studentId, BuildContext context) async {
    try {
      final Map<String, dynamic> body = {
        'password': password,
        'student_id': studentId,
      };
      'Map: $body'.log();
      String url = mainUrl + login;
      'Url: $url'.log();
      http.Response response = await http.post(Uri.parse(url), body: body);
      'Respone:  ${response.body}'.log();
      if (response.statusCode == 200) {
        _secureHelperLogin.writeUserLogin(response.body);
        _loginModel = await compute(jsonLoginUser, response.body);
        _secureHelperLogin.writeToken(_loginModel.data.accessToken);
        'Token User: ${loginModel.data.accessToken}'.log();
        _secureHelperLogin.wrtieRole(_loginModel.data.user.roles);
        'Role User: ${_loginModel.data.user.roles}'.log();
        if (_loginModel.data.user.roles == 'Student') {
          'Student Login'.log();
          Future.delayed(const Duration(milliseconds: 600), () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const HomeViewStudent();
            }), (route) => false);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 600), () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const HomeViewTeacher();
            }), (route) => false);
          });
        }
        _loadingStatus = LoadingStatus.done;
        return true;
      } else {
        _loadingStatus = LoadingStatus.error;
        return false;
      }
    } catch (error) {
      'Respone Error: $error'.log();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username and Password incorrect')));
      _loadingStatus = LoadingStatus.error;
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> logoutController(BuildContext context) async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token User :${token[0]}'.log();
      String url = mainUrl + logout;
      'Url: $url'.log();
      http.Response response = await http.post(Uri.parse(url), headers: header);
      'Respone Body: ${response.body}'.log();
      if (response.statusCode == 200) {
        _secureHelperLogin.deleteLocalUserLogin();
        await Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const LoginView();
          }), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User has been logout')));
        });
        return true;
      } else {
        'Other error'.log();
        return false;
      }
    } catch (error) {
      'Error respone: $error'.log();
      return false;
    } finally {
      notifyListeners();
    }
  }

  void readLocalUser() async {
    var user = await _secureHelperLogin.readUserInfor();
    if (user == _secureHelperLogin.noData) {
      _loadingStatus = LoadingStatus.error;
    } else {
      _localLogin = await compute(jsonLoginUser, user);
      'User infor: $user'.log();
      _loadingStatus = LoadingStatus.done;
    }
    notifyListeners();
  }
}

RegisterModel jsonRegisterUser(String str) {
  return RegisterModel.fromJson(json.decode(str));
}

LoginModel jsonLoginUser(String jsonString) {
  return LoginModel.fromJson(json.decode(jsonString));
}
