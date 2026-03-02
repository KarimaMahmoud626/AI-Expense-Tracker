import 'package:ai_expense_tracker/core/navigation/navigation_shell.dart';
import 'package:ai_expense_tracker/core/routes/app_routes.dart';
import 'package:ai_expense_tracker/features/ai_caht/presentation/pages/ai_chat_view/ai_chat_view.dart';
import 'package:ai_expense_tracker/features/analytics/presentation/pages/reports/reports_view.dart';
import 'package:ai_expense_tracker/features/auth/presentation/pages/login/login_view.dart';
import 'package:ai_expense_tracker/features/home/presentation/pages/home_view/home_view.dart';
import 'package:ai_expense_tracker/features/onboarding/presentation/pages/onboarding_view/onboarding_view.dart';
import 'package:ai_expense_tracker/features/transactions/presentation/pages/transactions/transactions_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.onboarding:
        return _buildRoute(OnboardingView(), settings: settings);

      case AppRoutes.login:
        return _buildRoute(LoginView(), settings: settings);

      case AppRoutes.main:
        return _buildRoute(NavigationShell(), settings: settings);

      case AppRoutes.aiChat:
        return _buildRoute(AiChatView(), settings: settings);

      case AppRoutes.home:
        return _buildRoute(HomeView(), settings: settings);

      case AppRoutes.transactions:
        return _buildRoute(TransactionsView(), settings: settings);

      case AppRoutes.reports:
        return _buildRoute(ReportsView(), settings: settings);

      default:
        return _errorRoute(settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page, {
    required RouteSettings settings,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }

  /// Returns an error route when the requested route is not found.
  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder:
          (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Route not found: ${settings.name}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
      settings: settings,
    );
  }
}
