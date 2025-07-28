import 'package:api_project/model/digimon_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://digimon-api.vercel.app/api/digimon";

  Future<List<DigimonModel>> fetchAllDigimon() async {
    try {
      final response = await _dio.get(_baseUrl);
      List data = response.data;
      return data.map((json) => DigimonModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Data Upload Failed");
    }
  }

  Future<List<DigimonModel>> fetchByName(String name) async {
    try {
      final response = await _dio.get('$_baseUrl/name/$name');
      List data = response.data;
      return data.map((json) => DigimonModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("No Digimon Found");
    }
  }
}
