part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthGetUserLoading extends AuthState {}

class AuthGetUserSuccess extends AuthState {}

class AuthGetUserError extends AuthState {
  final String error;
  AuthGetUserError(this.error);
}
