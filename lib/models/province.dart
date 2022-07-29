import 'dart:convert';

class ProvinceModel {
  int provinceId;
  String province;
  ProvinceModel({
    required this.provinceId,
    required this.province,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'provincia_id': provinceId,
      'provincia': province,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      provinceId: map['provincia_id'] as int,
      province: map['provincia'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) => ProvinceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
