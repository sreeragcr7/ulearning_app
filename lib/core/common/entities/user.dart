class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
  });

  final String id;
  final String username;
  final String email;
  final String? avatar;
}

// class LoginRequestEntity {
//   int? type;
//   String? name;
//   String? description;
//   String? email;
//   String? phone;
//   String? avatar;
//   String? open_id;
//   int? online;

//   LoginRequestEntity({
//     this.type,
//     this.name,
//     this.description,
//     this.email,
//     this.phone,
//     this.avatar,
//     this.open_id,
//     this.online,
//   });
