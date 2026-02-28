import 'package:ai_expense_tracker/core/di/dependency_injection_container.dart';
import 'package:ai_expense_tracker/core/routes/app_routes.dart';
import 'package:ai_expense_tracker/core/routes/route_generator.dart';
import 'package:ai_expense_tracker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await initDependecies();

  runApp(const AIExpenseTracker());
}

class AIExpenseTracker extends StatelessWidget {
  const AIExpenseTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme,
        ),
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
