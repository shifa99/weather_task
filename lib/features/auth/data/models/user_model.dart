import 'package:weather_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
  });
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      name: data['name'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email':email,
      'name':name,
    };
  }
}
