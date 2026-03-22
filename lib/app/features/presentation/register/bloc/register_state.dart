import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String passwordAgain;
  final bool isLoading;
  final bool isSuccessfull;
  final String? errorMessage;

  const RegisterState({
    this.isLoading = false,
    this.isSuccessfull = false,
    this.errorMessage,
    required this.email,
    required this.password,
    required this.passwordAgain,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? passwordAgain,
    bool? isLoading,
    bool? isSuccessfull,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordAgain: passwordAgain ?? this.passwordAgain,
      isLoading: isLoading ?? this.isLoading,
      isSuccessfull: isSuccessfull ?? this.isSuccessfull,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    passwordAgain,
    password,
    isLoading,
    isSuccessfull,
    errorMessage,
  ];
}
