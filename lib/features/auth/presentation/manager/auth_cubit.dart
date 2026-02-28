import 'package:ai_expense_tracker/core/errors/failures.dart';
import 'package:ai_expense_tracker/core/utils/app_logger.dart';
import 'package:ai_expense_tracker/features/auth/data/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;
  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> googleSignIn() async {
    AppLogger.info('Google sign-in requested');
    emit(AuthLoading());

    final result = await repo.loginWithGoogle();

    result.fold(
      (failure) {
        AppLogger.warning('Google sign-in failed: ${failure.message}');
        emit(AuthError(errorMessage: _getErrorMessage(failure)));
      },
      (userCredential) {
        AppLogger.info('Google sign-in successful');
        emit(AuthSuccess(userCred: userCredential));
      },
    );
  }

  /// Handles email/password sign-in authentication flow.
  ///
  /// Emits [AuthLoading] while processing, then either [AuthSuccess]
  /// with user credentials or [AuthError] if authentication fails.
  Future<void> emailSignIn(
    String email,
    String password, {
    String? name,
  }) async {
    AppLogger.info('Email sign-in requested for: $email');
    emit(AuthLoading());

    final result = await repo.signInwithEmailAndPassword(
      email,
      password,
      name: name,
    );

    result.fold(
      (failure) {
        AppLogger.warning('Email sign-in failed: ${failure.message}');
        emit(AuthError(errorMessage: _getErrorMessage(failure)));
      },
      (userCredential) {
        AppLogger.info('Email sign-in successful');
        emit(AuthSuccess(userCred: userCredential));
      },
    );
  }

  /// Converts a [Failure] to a user-friendly error message.
  ///
  /// Provides specific messages for different failure types.
  String _getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    } else if (failure is AuthFailure) {
      return failure.message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
