import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithEmail(String email, String password);
  Future<UserCredential> createWithEmail(String email, String password);
  Future<void> saveUserData(UserModel user);
}
