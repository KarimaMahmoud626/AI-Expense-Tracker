import 'package:ai_expense_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_expense_tracker/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:ai_expense_tracker/features/auth/data/repos/auth_repo.dart';
import 'package:ai_expense_tracker/features/auth/domain/repos/auth_repo_impl.dart';
import 'package:ai_expense_tracker/features/auth/domain/services/auth_services.dart';
import 'package:ai_expense_tracker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final getIt = GetIt.instance;

Future<void> initDependecies() async {
  _registerAuth();
}

void _registerAuth() {
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerLazySingleton(() => AuthServices());

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () =>
        AuthRemoteDataSourceImpl(getIt<FirebaseAuth>(), getIt<GoogleSignIn>()),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      dataSource: getIt<AuthRemoteDataSource>(),
      authServices: getIt<AuthServices>(),
    ),
  );

  getIt.registerFactory(() => AuthCubit(getIt<AuthRepo>()));
}
