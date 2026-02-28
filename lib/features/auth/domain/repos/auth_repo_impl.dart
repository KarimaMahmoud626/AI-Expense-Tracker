import 'dart:io';

import 'package:ai_expense_tracker/core/errors/failures.dart';
import 'package:ai_expense_tracker/core/utils/app_logger.dart';
import 'package:ai_expense_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:ai_expense_tracker/features/auth/data/repos/auth_repo.dart';
import 'package:ai_expense_tracker/features/auth/domain/services/auth_services.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource dataSource;

  AuthRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, UserCredential>> loginWithGoogle() async {
    try {
      final userCredential = await dataSource.signInWithGoogle();

      // Validate user data
      final user = userCredential.user;
      if (user == null || user.email == null) {
        AppLogger.error('Google sign-in returned null user or email');
        return const Left(
          AuthFailure(
            'Failed to get user information from Google',
            code: 'null-user-data',
          ),
        );
      }

      // Save user data to Firestore
      await dataSource.saveUserData(
        UserModel(email: user.email!, name: user.displayName!, uid: user.uid),
      );

      AppLogger.info('Google sign-in successful for user: ${user.email}');
      return Right(userCredential);
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error(
        'Firebase auth error during Google sign-in',
        e,
        stackTrace,
      );

      return Left(AuthServices().firebaseAuthErrorType(e));
    } on SocketException catch (e, stackTrace) {
      AppLogger.error('Network error during Google sign-in', e, stackTrace);
      return const Left(
        NetworkFailure('No internet connection. Please check your network.'),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error during Google sign-in', e, stackTrace);
      return Left(AuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInwithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCred = await dataSource.createWithEmail(email, password);

      final user = userCred.user;
      if (user == null || user.email == null) {
        AppLogger.error('Email sign-in returned null user or email');
        return const Left(
          AuthFailure('Failed to get user information', code: 'null-user-data'),
        );
      }

      await dataSource.saveUserData(
        UserModel(name: user.displayName!, email: user.email!, uid: user.uid),
      );

      AppLogger.info('Account created succesfully for: $email');
      return Right(userCred);
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.warning('Firebase Auth error during email sign-in', e);

      switch (e.code) {
        case 'weak-password':
          return const Left(
            AuthFailure(
              'Password is too weak. Please use a strongger password with at least 6 characters.',
              code: 'weak-password',
            ),
          );
        case 'email-already-in-use':
          final result = await loginWithEmail(email, password);
          return result.fold(
            (failure) {
              return Left(AuthFailure(failure.message, code: failure.code));
            },
            (userCredential) {
              return Right(userCredential);
            },
          );
        case 'wrong-password':
          return const Left(
            AuthFailure(
              'Incorrect password. Please try again.',
              code: 'wrong-password',
            ),
          );
        case 'network-request-failed':
          return const Left(
            NetworkFailure(
              'Network error. Please check your internet connection.',
            ),
          );
        default:
          return Left(
            AuthFailure(e.message ?? 'Authentication failed', code: e.code),
          );
      }
    } on SocketException catch (e, stackTrace) {
      AppLogger.error('Network error during email sign-in', e, stackTrace);
      return const Left(
        NetworkFailure('No internet connection. Please check your network.'),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error during email sign-in', e, stackTrace);
      return Left(AuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await dataSource.signInWithEmail(email, password);

      final user = userCredential.user;
      if (user == null || user.email == null) {
        return const Left(
          AuthFailure('Failed to get user information', code: 'null-user-data'),
        );
      }

      await dataSource.saveUserData(
        UserModel(name: user.displayName!, email: user.email!, uid: user.uid),
      );
      AppLogger.info('Sign-in successful for existing user: $email');
      return Right(userCredential);
    } on FirebaseAuthException catch (signInError) {
      if (signInError.code == 'wrong-password') {
        return const Left(
          AuthFailure(
            'An account with this email already exists. Please sign in with the correct password.',
            code: 'email-already-in-use',
          ),
        );
      }
      return Left(
        AuthFailure(
          signInError.message ?? 'Authentication failed',
          code: signInError.code,
        ),
      );
    }
  }
}
