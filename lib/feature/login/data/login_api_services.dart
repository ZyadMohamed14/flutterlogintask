import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user_model.dart';

class LoginApiServices {
  final FirebaseAuth auth;


  LoginApiServices({required this.auth});

  /// Returns Either<Failure, UserDetailsModel?> where Failure contains the error message.
  Future<Either<String, UserDetailsModel>> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Attempt to sign in
      UserCredential response = await auth.signInWithEmailAndPassword(email: email, password: password);

      User? user = response.user;

      if (user != null) {

        // Successful login, return user details
        return Right(UserDetailsModel(
          id: user.uid,
          email: user.email,
          name: user.displayName ?? '',
          phone: user.phoneNumber ?? '',
          image: user.photoURL ?? '',
          disabled: user.isAnonymous,
        ));
      } else {
        return Left("Login failed: User not found.");
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      return Left("FirebaseAuthException: ${e.message}");
    } catch (e) {
      // Handle other errors

      return Left("An unexpected error occurred: $e");
    }
  }
}