class UserModel {
  final bool status;
  final String? message;
  final UserDate? data;
  UserModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      status: jsonData['status'],
      message: jsonData['message'] != null ? jsonData['message'] : null,
      data:
          jsonData['data'] != null ? UserDate.fromJson(jsonData['data']) : null,
    );
  }
}

class UserDate {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final int? points;
  final int? credit;
  final String token;
  UserDate({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.points,
    this.credit,
    required this.token,
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
