import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as service;
import 'package:project/db_helper/secure_helper/cache_solution.dart';
import 'package:project/models/teacher_models/notic_event_model.dart';

import '/constants/loading_status.dart';
import '/constants/logger.dart';
import '/constants/url_base.dart';
import '../../db_helper/secure_helper/secure_helper_login.dart';

class NoticController with ChangeNotifier {
  final SecureHelperLogin _secureHelperLogin = SecureHelperLogin();

  NoticModel _noticModel = NoticModel();
  NoticModel get noticModel => _noticModel;

  LoadingStatus _loadingStatus = LoadingStatus.none;
  LoadingStatus get loadingStatus => _loadingStatus;

  void setLoading() {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();
  }

  final CacheSolution _cacheSolution = CacheSolution();

  void readNotic() async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + notic;
      service.Response response =
          await service.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        _cacheSolution.writeSolution(response.body);
      }
    } catch (err) {
      'Respone: $err'.log();
      _loadingStatus = LoadingStatus.error;
    } finally {
      String cache = await _cacheSolution.readSolution();
      if (cache == _cacheSolution.noSolution) {
        _loadingStatus = LoadingStatus.error;
      } else {
        _noticModel = await compute(pareJsonSolution, cache);
        _loadingStatus = LoadingStatus.done;
      }
      notifyListeners();
    }
  }

  String _fileName = '';
  String get fileName => _fileName;

  List<int> _fileBytes = [];
  List<int> get fileBytes => _fileBytes;

  String _fileBase64 = '';
  String get fileBase64 => _fileBase64;

  File? _localFile;
  File? get localFile => _localFile;

  final _serviceName = 'Location Service';

  Future<void> getFileBase64String(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpeg', 'png', 'jpg', 'pdf'],
      );
      if (result == null) return;

      _fileName = result.files.first.name;

      final filePath = result.files.first.path.toString();
      final int fileSize = result.files.first.size;
      final String fileName = result.files.first.name;
      final String fileExtension =
          fileName.substring(fileName.lastIndexOf('.') + 1);
      'fileExtension: $fileExtension'.log();

      var typeFile = File(filePath);
      _localFile = typeFile;

      //handle the image file upload
      if (fileExtension != 'pdf') {
        final double totalSize = fileSize / 1000;
        if (totalSize / 1000 > 1) {
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
          final List<int> imageBytes = typeFile.readAsBytesSync();
          _fileBytes = imageBytes;
          _fileBase64 =
              "data:image/$fileExtension;base64,${base64Encode(imageBytes)}";
          // "Base 64: $_fileBase64".log();
          Future.delayed(const Duration(milliseconds: 600), () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File has been added...'),
              ),
            );
          });
        }
      } else {
        var totalSize = fileSize / 1000;
        if (totalSize / 1000 > 1) {
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
        final List<int> pdfBytes = typeFile.readAsBytesSync();
        _fileBytes = pdfBytes;
        _fileBase64 = "data:@file/pdf;base64,${base64Encode(pdfBytes)}";
      }
    } catch (err) {
      '$_serviceName getPatenBase64String exception: $err'.log();
    } finally {
      '$_serviceName getPatenBase64String finally'.log();
      notifyListeners();
    }
  }

  LoadingStatus _createSolutionLoading = LoadingStatus.none;
  LoadingStatus get createSolutionLoading => _loadingStatus;

  void setLoadingCreateSolution() {
    _createSolutionLoading = LoadingStatus.loading;
    notifyListeners();
  }

  Future<bool> createNotic(String text, String file) async {
    try {
      var token = await _secureHelperLogin.readUserLogin();
      final Map<String, dynamic> map = {
        'text': text,
        'file': file,
      };
      final body = jsonEncode(map);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token[0]}',
      };
      'Token Header: ${token[0]}'.log();
      String url = mainUrl + notic;
      service.Response response =
          await service.post(Uri.parse(url), headers: header, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      'Respone: $e'.log();
      return false;
    } finally {
      notifyListeners();
    }
  }
}

NoticModel pareJsonSolution(String jsonString) =>
    NoticModel.fromJson(json.decode(jsonString));
