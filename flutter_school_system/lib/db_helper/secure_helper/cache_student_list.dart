import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheStudentList{
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String student = 'student';
  final String noStudent = 'no-student';

  void writeStudentList(String value){
    _secureStorage.write(key: student, value: value);
  }

  Future<String> readStudent()async{
    String? cache = await _secureStorage.read(key: student);
    return cache ?? noStudent;
  }

  void clearLocal(){
    _secureStorage.deleteAll();
  }
}