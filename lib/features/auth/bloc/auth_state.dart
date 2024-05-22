import 'package:kanlas_assignment/model/user_model.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;

  final UserModel? userModel;

  const AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.userModel,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserModel? userModel,
    bool? isLoading,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userModel: userModel ?? this.userModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
