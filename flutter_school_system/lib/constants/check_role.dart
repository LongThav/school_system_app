import 'package:flutter/material.dart';

import '../constants/logger.dart';
import '../views/login_view.dart';
import '../views/teachers/home_view_teacher.dart';
import '../db_helper/secure_helper/secure_helper_login.dart';
import '../views/students/home_view_student.dart';

class CheckRole {
  void checkUser(BuildContext context) async {
    SecureHelperLogin secureHelperLogin = SecureHelperLogin();
    var token = await secureHelperLogin.readUserLogin();
    'get Token User: ${token[0]}'.log();
    var role = await secureHelperLogin.readRole();
    'Roles user: $role'.log();
    if (token[0] == null || token[0] == '') {
      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const LoginView();
        }), (route) => false);
      });
    } else {
      if (role == 'Student') {
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const HomeViewStudent();
          }), (route) => false);
        });
      } else if (role == 'Teacher') {
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const HomeViewTeacher();
          }), (route) => false);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 600), () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not allow')));
        });
      }
    }
  }
}
