import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:project/models/section_model.dart';

import '../constants/loading_status.dart';
import '../constants/logger.dart';
import '../constants/url_base.dart';
import '../db_helper/secure_helper/secure_helper_login.dart';
import '../models/role_model.dart';

class FormController extends ChangeNotifier {
  RoleModel _roleModel = RoleModel();
  RoleModel get roleModel => _roleModel;

  SessionModel _sectionModel = SessionModel();
  SessionModel get sectionModel => _sectionModel;

  LoadingStatus _loadingStatus = LoadingStatus.none;
  LoadingStatus get loadingStatus => _loadingStatus;

  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();
  }

  final SecureHelperLogin _secureHelperLogin = SecureHelperLogin();

  void readRole() async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + getRole;
      'Respone Body: $url'.log();
      http.Response response = await http.get(Uri.parse(url), headers: header);
      'Respone Body: $response'.log();
      if (response.statusCode == 200) {
        _roleModel = await compute(pareJsonRole, response.body);
        _loadingStatus = LoadingStatus.done;
      }
    } catch (e) {
      'Respone Error: $e'.log();
      _loadingStatus = LoadingStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void readSection() async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      String url = mainUrl + sessioin;
      'Respone Body: $url'.log();
      http.Response response = await http.get(Uri.parse(url), headers: header);
      'Respone Body: $response'.log();
      if (response.statusCode == 200) {
        _sectionModel = await compute(pareJsonSection, response.body);
        _loadingStatus = LoadingStatus.done;
      }
    } catch (error) {
      'Respone error: $error'.log();
      _loadingStatus = LoadingStatus.error;
    } finally {
      notifyListeners();
    }
  }
}

RoleModel pareJsonRole(String jsonString) {
  return RoleModel.fromJson(json.decode(jsonString));
}

SessionModel pareJsonSection(String jsonString) {
  return SessionModel.fromJson(json.decode(jsonString));
}
