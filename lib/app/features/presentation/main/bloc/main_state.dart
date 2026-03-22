import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int selectedIndex;
  final bool logoutSuccessful;
  final bool isLoading;
  final String? errorMessage;

  const MainState({
    this.selectedIndex = 0,
    required this.logoutSuccessful,
    required this.isLoading,
    this.errorMessage,
  });

  MainState copyWith({
    int? selectedIndex,
    bool? logoutSuccessful,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      logoutSuccessful: logoutSuccessful ?? this.logoutSuccessful,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedIndex,
    logoutSuccessful,
    isLoading,
    errorMessage,
  ];
}
