// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fullName;
  String email;
  String phone;
  String province;
  String password;
  double balance;
  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.province,
    required this.password,
    this.balance = 0.0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'province': province,
      'password': password,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      province: map['province'],
      password: map['password'],
      balance: double.tryParse(map['balance']?.toString() ?? "") ?? 0.0,
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }
  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? province,
    String? password,
    double? balance,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      password: password ?? this.password,
      balance: balance ?? this.balance,
    );
  }
}
