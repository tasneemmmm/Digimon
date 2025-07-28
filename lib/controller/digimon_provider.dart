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
      _digimonList = await _apiService.fetchAllDigimon();
      _filteredList = _digimonList;
    } catch (e) {
      _digimonList = [];
      _filteredList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchByName(String name) {
    if (name.isEmpty) {
      _filteredList = _digimonList;
    } else {
      _filteredList = _digimonList
          .where(
            (digimon) =>
                digimon.name.toLowerCase().contains(name.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
