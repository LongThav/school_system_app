import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureUserRegister{
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String user = 'user';
  final String noData = "noData";

  void writeUserRegister(String value){
    _secureStorage.write(key: user, value: value);
  }

  Future<String> readUserRegister()async{
    String? userInfo = await _secureStorage.read(key: user);
    return userInfo ?? noData;
  }

  void deleteUser(){
    _secureStorage.deleteAll();
  }
}

