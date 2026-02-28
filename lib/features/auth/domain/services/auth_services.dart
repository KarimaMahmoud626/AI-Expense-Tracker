import 'package:ai_expense_tracker/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Failure firebaseAuthErrorType(FirebaseAuthException e) {
    switch (e.code) {
      case 'sign_in_canceled':
        return const AuthFailure(
          'Sign-in was canceled',
          code: 'sign-in-canceled',
        );
      case 'network-request-failed':
        return NetworkFailure(
          'Network error. Please check your internet connection.',
        );
      case 'account-exists-with-different-credential':
        return AuthFailure(
          'An account already exists with the same email but different sign-in method',
          code: 'account-exists',
        );
      default:
        return AuthFailure(e.message ?? 'Google sign-in failed', code: e.code);
    }
  }
}
