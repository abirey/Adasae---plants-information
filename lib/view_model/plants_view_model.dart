import 'package:adasae/models/data_api.dart';
import 'package:adasae/repository/plants_repository.dart';
import 'package:flutter/foundation.dart';

class PlantsViewModel {
  final _rep = PlantsRepository();

  Future<List<Data>> fetchNewPlantTitleApi(int page) async {
    return _rep.fetchNewPlantTitleApi(page);
  }

  Future<int> fetchTotalPages() async {
    return _rep.fetchTotalPages();
  }

  Future<List<Data>> searchPlant(String query) async {
  try {
    return await _rep.searchPlant(query);
  } catch (e) {
    if (kDebugMode) {
      print('Error searching plant: $e');
    }
    rethrow;
  }
}

Future<Data> idPlant(int query) async {
  try {
    return await _rep.idPlant(query);
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching plant: $e');
    }
    rethrow;
  }
}

}
