import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterFieldChanged extends RegisterEvent {
  final String? email;
  final String? password;
  final String? passwordAgain;

  const RegisterFieldChanged({this.email, this.password, this.passwordAgain});

  @override
  List<Object?> get props => [email, password, passwordAgain];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
