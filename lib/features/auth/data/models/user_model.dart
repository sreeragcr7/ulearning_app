import 'package:ulearning_app/core/common/entities/entities.dart';

class UserModel extends User {
  UserModel({required super.id, required super.username, required super.email, required super.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    String? avatar,
    String? description,
    String? role,
    bool? online,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}
