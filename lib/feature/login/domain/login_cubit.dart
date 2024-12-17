import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/login_api_services.dart';
import '../data/login_repo_implementation.dart';
import '../data/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginApiServices loginService;

  LoginCubit({required this.loginService}) : super(LoginInitial());

  /// Performs login and emits states based on the result
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading()); // Emit loading state

    final result = await loginService.loginWithEmailAndPassword(email, password);

    result.fold(
      // On Failure
          (error) => emit(LoginFailure(error)),

      // On Success
          (userDetails) => emit(LoginSuccess(userDetails)),
    );
  }
}