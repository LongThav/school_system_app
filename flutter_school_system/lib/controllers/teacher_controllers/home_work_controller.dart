import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

import '/constants/url_base.dart';
import '/constants/loading_status.dart';
import '/constants/logger.dart';
import '/models/teacher_models/home_work_model.dart';
import '../../db_helper/secure_helper/secure_helper_login.dart';

class HomeWorkController extends ChangeNotifier {
  HomeWorkModel _homeWorkModel = HomeWorkModel();
  HomeWorkModel get homeWorkModel => _homeWorkModel;

  LoadingStatus _loadingStatus = LoadingStatus.none;
  LoadingStatus get loadingStatus => _loadingStatus;

  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();
  }

  final SecureHelperLogin _secureHelperLogin = SecureHelperLogin();

  void readHomeWork() async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + homeWork;
      'Url :$url'.log();
      http.Response response = await http.get(Uri.parse(url), headers: header);
      'Respone Body: ${response.body}'.log();
      if (response.statusCode == 200) {
        _homeWorkModel = await compute(pareJsonHomeWork, response.body);
        _loadingStatus = LoadingStatus.done;
      }
    } catch (error) {
      'Respone error: $error'.log();
      _loadingStatus = LoadingStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createHomeWork(String title, String file) async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + homeWork;
      'Url :$url'.log();
      //http://localhost:8000/api/homework
      Map<String, dynamic> map = {'text': title, 'file': file};
      final body = jsonEncode(map);
      http.Response response =
          await http.post(Uri.parse(url), headers: header, body: body);
      // 'map: $map'.log();
      'Respone Body: ${response.body}'.log();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      'Respone error: $error'.log();
      return false;
    } finally {
      notifyListeners();
    }
  }


  String _patenName = '';
  String get patenName => _patenName;

  List<int> _patenBytes = [];
  List<int> get patenBytes => _patenBytes;

  String _patenBase64FileStr = '';
  String get patenBase64FileStr =>
      _patenBase64FileStr; // This base64 file can be pdf or images
  File? _localFile;
  File? get localFile => _localFile;
  final _serviceName = 'Location Service';

  Future<void> getPatenBase64String(BuildContext context) async {
    '$_serviceName getPatenBase64String called...'.log();
    try {
      /// Processing Upload Paten File or Photo File as Base64 String
      'upload Paten File tapped...'.log();
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpeg', 'png', 'jpg', 'pdf'],
        // allowedExtensions: ['png', 'pdf'],
      );
      // if no file is picked
      if (result == null) return;

      // we will log the name, size and path of the
      'name: ${result.files.first.name}'.log();
      'size: ${result.files.first.size}'.log();
      'path: ${result.files.first.path}'.log();

      _patenName = result.files.first.name;

      final filePath = result.files.first.path.toString(); // filePath
      final int fileSize = result.files.first.size; // file size
      final String fileName = result.files.first.name; // file name
      final String fileExtension =
          fileName.substring(fileName.lastIndexOf('.') + 1);
      'fileExtension: $fileExtension'.log();

      var patenFile = File(filePath);
      _localFile = patenFile;

      /// handle the image file upload ~= 1MB only
      if (fileExtension != 'pdf') {
        final double totalSize = fileSize / 1000; // 1000 bytes => 1KB
        if (totalSize / 1000 > 1) {
          // 1000 KB => 1MB
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('The file is large, please choose other image...'),
              ),
            );
          }
          return;
        } else {
          /// handle image processing ...
          final List<int> imageBytes = patenFile.readAsBytesSync();
          _patenBytes = imageBytes;
          _patenBase64FileStr =
              "data:image/$fileExtension;base64,${base64Encode(imageBytes)}";
          "Base 64: $_patenBase64FileStr".log();
        }
      } else {
        /// handle pdf's size upload ~= 1MB only
        var totalSize = fileSize / 1000;
        if (totalSize / 1000 > 1) {
          // 1000 KB => 1MB
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('The file is large, please choose other image...'),
              ),
            );
          }
          return;
        }

        /// handling pdf processing
        final List<int> pdfBytes = patenFile.readAsBytesSync();
        _patenBytes = pdfBytes;
        _patenBase64FileStr = "data:@file/pdf;base64,${base64Encode(pdfBytes)}";
      }
    } catch (e) {
      '$_serviceName getPatenBase64String exception: $e'.log();
    } finally {
      '$_serviceName getPatenBase64String finally'.log();
    }
  }
}

HomeWorkModel pareJsonHomeWork(String jsonString) {
  return HomeWorkModel.fromJson(json.decode(jsonString));
}
