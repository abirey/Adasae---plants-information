import 'dart:convert';
import 'package:adasae/models/data_api.dart';
import 'package:http/http.dart' as http;

class PlantsRepository {
  Future<List<Data>> fetchNewPlantTitleApi(int page) async {
    List<Data> plants = [];
    String url = 'https://trefle.io/api/v1/plants?token=2dmmmfOpzSxfpojeZLRWTx9dQOl-MgagW3Xxnx94_Xc&page=$page';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      DataApiPlant dataApiPlant = DataApiPlant.fromJson(jsonResponse);
      plants = dataApiPlant.data!;
    } else {
      throw Exception('Failed to load plants data from API');
    }

    return plants;
  }

  Future<int> fetchTotalPages() async {
  String url = 'https://trefle.io/api/v1/plants?token=2dmmmfOpzSxfpojeZLRWTx9dQOl-MgagW3Xxnx94_Xc';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    int totalPages = jsonResponse['meta']['total_pages'];
    return totalPages;
  } else {
    throw Exception('Failed to load total pages data from API');
  }
}

Future<List<Data>> searchPlant(String query) async {
  List<Data> plants = [];
  String url = 'https://trefle.io/api/v1/plants/search?token=2dmmmfOpzSxfpojeZLRWTx9dQOl-MgagW3Xxnx94_Xc&q=$query';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    DataApiPlant dataApiPlant = DataApiPlant.fromJson(jsonResponse);
    plants = dataApiPlant.data!;
  } else {
    throw Exception('Failed to search plants data from API');
  }

  return plants;
}

Future<Data> idPlant(int query) async {
  List<Data> plants = [];
  String url = 'https://trefle.io/api/v1/plants?token=2dmmmfOpzSxfpojeZLRWTx9dQOl-MgagW3Xxnx94_Xc&filter[id]=$query';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    DataApiPlant dataApiPlant = DataApiPlant.fromJson(jsonResponse);
    plants = dataApiPlant.data!;
    return plants.isNotEmpty ? plants[0] : Data(); // Return the first plant if available
  } else {
    throw Exception('Failed to search plants id from API');
  }
}




}
