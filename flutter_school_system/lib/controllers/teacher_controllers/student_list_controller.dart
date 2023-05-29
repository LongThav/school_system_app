import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '/constants/url_base.dart';
import '/db_helper/secure_helper/cache_student_list.dart';
import '/constants/loading_status.dart';
import '/constants/logger.dart';
import '/models/teacher_models/student_list.dart';
import '../../db_helper/secure_helper/secure_helper_login.dart';

class TecherControllerStudentList extends ChangeNotifier {
  StudentList _studentList = StudentList(data: Data());
  StudentList get studentList => _studentList;

  LoadingStatus _loadingStatus = LoadingStatus.none;
  LoadingStatus get loadingStatus => _loadingStatus;

  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();
  }

  final SecureHelperLogin _secureHelperLogin = SecureHelperLogin();
  final CacheStudentList _cacheStudentList = CacheStudentList();

  void readStudentList() async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + user;
      http.Response response = await http.get(Uri.parse(url), headers: header);
      'Respone Body: ${response.body}'.log();
      if (response.statusCode == 200) {
        _cacheStudentList.writeStudentList(response.body);
      }
    } catch (error) {
      'Respone Error: $error'.log();
      _loadingStatus = LoadingStatus.error;
    } finally {
      String cache = await _cacheStudentList.readStudent();
      if (cache == _cacheStudentList.noStudent) {
        'Cache no Data'.log();
        _loadingStatus = LoadingStatus.error;
      } else {
        _studentList = await compute(pareJsonStudentList, cache);
        'Cachh Data: $cache'.log();
        _loadingStatus = LoadingStatus.done;
      }
      notifyListeners();
    }
  }
}

StudentList pareJsonStudentList(String jsonString) {
  return StudentList.fromJson(json.decode(jsonString));
}
