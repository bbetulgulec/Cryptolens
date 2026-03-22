import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String password;

  const UserModel({required this.email, required this.password});

  UserModel copyWith({String? email, String? password}) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"] ?? '',
      password: map["password"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }

  @override
  List<Object?> get props => [email, password];
}
