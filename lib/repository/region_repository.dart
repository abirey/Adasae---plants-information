import 'dart:convert';
import 'package:adasae/models/region_api.dart';
// import 'package:adasae/models/data_api.dart';
import 'package:http/http.dart' as http;

class RegionRepository {
  Future<List<Data>> fetchRegionApi() async {
    List<Data> region = [];
    String url = 'https://trefle.io/api/v1/distributions?token=2dmmmfOpzSxfpojeZLRWTx9dQOl-MgagW3Xxnx94_Xc';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      DataApiRegion dataApiRegion = DataApiRegion.fromJson(jsonResponse);
      region = dataApiRegion.data!;
    } else {
      throw Exception('Failed to load region data from API');
    }

    return region;
  }




}
