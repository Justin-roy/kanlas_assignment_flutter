import 'package:kanlas_assignment/model/user_model.dart';

class AuthState {
  final bool isAuthenticated;

  final UserModel? userModel;

  const AuthState({
    required this.isAuthenticated,
    this.userModel,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserModel? userModel,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userModel: userModel ?? this.userModel,
    );
  }
}
