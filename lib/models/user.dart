import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fullName;
  String email;
  String phone;
  String province;
  String password;
  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.province,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'province': province,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      province: map['province'] as String,
      password: map['password'] as String,
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }
  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
