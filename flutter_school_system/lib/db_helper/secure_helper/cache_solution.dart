import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheSolution{
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String solution = 'key';
  final String noSolution = 'no';

  void writeSolution(String value){
    _secureStorage.write(key: solution, value: value);
  }

  Future<String> readSolution()async{
    String? cache = await _secureStorage.read(key: solution);
    return cache ?? noSolution;
  }

  void clearLocal(){
    _secureStorage.deleteAll();
  }
}