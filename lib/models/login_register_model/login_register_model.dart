import 'package:flutter/foundation.dart';

class ShopModel {
  final bool status;
  final String message;
  final UserDate data;  // بالاساس المفروض ان يكون ديناميك
  ShopModel({
     this.status,
     this.message,
     this.data,
  });

  factory ShopModel.fromJson(Map<String, dynamic> jsonData) {
    return ShopModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: jsonData['data'] != null ? UserDate.fromJson(jsonData['data']) : null,
    );
  }
}

class UserDate {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;
  UserDate({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    this.image,
    this.points,
    this.credit,
    @required this.token,
  });

  factory UserDate.fromJson(Map<String, dynamic> jsonData) {
    return UserDate(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      image: jsonData['image'],
      points: jsonData['points'],
      credit: jsonData['credit'],
      token: jsonData['token'],
    );
  }
}
