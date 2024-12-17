part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

/// Initial state before any action
final class LoginInitial extends LoginState {}

/// Loading state when the login process is ongoing
final class LoginLoading extends LoginState {}

/// Success state when login is successful
final class LoginSuccess extends LoginState {
  final UserDetailsModel userDetails;

  LoginSuccess(this.userDetails);

  @override
  String toString() => 'LoginSuccess: ${userDetails.name}';
}

/// Failure state when login fails
final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);

  @override
  String toString() => 'LoginFailure: $errorMessage';
}
