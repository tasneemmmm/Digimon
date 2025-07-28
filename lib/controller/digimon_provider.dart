import 'package:api_project/api/api_service.dart';
import 'package:api_project/model/digimon_model.dart';
import 'package:flutter/material.dart';

class DigimonProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<DigimonModel> _digimonList = [];
  List<DigimonModel> _filteredList = [];
  bool _isLoading = false;

  List<DigimonModel> get digimonList => _digimonList;
  List<DigimonModel> get filteredDigimonList => _filteredList;
  bool get isLoading => _isLoading;

  Future<void> getAllDigimon() async {
    _isLoading = true;
    notifyListeners();

    try {
      _digimonList = [];
      _digimonList = await _apiService.fetchAllDigimonApi();
    } catch (e) {
      throw e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchByName(String name) async {
    _filteredList = [];
    _filteredList = await _apiService.fetchByName(name);

    notifyListeners();
  }
}
