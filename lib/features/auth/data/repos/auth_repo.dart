import 'package:ai_expense_tracker/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserCredential>> loginWithGoogle();
  Future<Either<Failure, UserCredential>> signInwithEmailAndPassword(
    String email,
    String password, {
    String? name,
  });
  Future<Either<Failure, UserCredential>> loginWithEmail(
    String email,
    String password, {
    String? name,
  });
}
