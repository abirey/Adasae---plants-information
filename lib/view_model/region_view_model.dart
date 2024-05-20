import 'package:adasae/models/region_api.dart';
import 'package:adasae/repository/region_repository.dart';
// import 'package:flutter/foundation.dart';

class RegionViewModel {
  final _rep = RegionRepository();
  Future<List<Data>> fetchRegionApi() async {
    return _rep.fetchRegionApi();
  }
}


