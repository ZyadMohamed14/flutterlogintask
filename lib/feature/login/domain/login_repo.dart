import 'package:dartz/dartz.dart';

import '../data/models/user_model.dart';

abstract class LoginRepository {

  Future<Either<String, UserDetailsModel>> login(String email, String password);
}