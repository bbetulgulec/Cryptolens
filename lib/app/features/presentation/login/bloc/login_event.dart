import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginFieldChanged extends LoginEvent {
  final String? email;
  final String? password;

  const LoginFieldChanged({this.email, this.password});

  @override
  List<Object?> get props => [email, password];
}

class Logined extends LoginEvent {
  const Logined();
}
