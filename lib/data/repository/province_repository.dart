import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:conoce_bonao/gen/assets.gen.dart';
import 'package:conoce_bonao/models/province.dart';

class ProvinceRepository {
  Future<List<ProvinceModel>> getProvinces() async {
    final jsonProvinces = await rootBundle.loadString(Assets.json.provinces);
    return List.of(json.decode(jsonProvinces)).map(_mapProvince).toList();
  }

  ProvinceModel _mapProvince(province) {
    return ProvinceModel.fromMap(province);
  }
}
