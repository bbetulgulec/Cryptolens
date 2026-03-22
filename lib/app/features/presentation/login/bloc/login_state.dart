import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccessfull;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.isSuccessfull = false,
    this.errorMessage,
    required this.email,
    required this.password,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccessfull,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccessfull: isSuccessfull ?? this.isSuccessfull,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isLoading,
    isSuccessfull,
    errorMessage,
  ];
}
