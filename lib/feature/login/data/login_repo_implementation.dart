import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../domain/login_repo.dart';
import 'login_api_services.dart';
import 'models/user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiServices apiServices;

  LoginRepositoryImpl({required this.apiServices});

  @override
  Future<Either<String, UserDetailsModel>> login(String email, String password) async {
    try {
      // Delegate the call to the API service
      final result = await apiServices.loginWithEmailAndPassword(email, password);

      return result.fold(
            (error) => Left(error), // Pass the failure message
            (userDetails) => Right(userDetails), // Pass the success data
      );
    } catch (e) {
      // Handle unexpected errors
      return Left("An unexpected error occurred in LoginRepository: $e");
    }
  }
}