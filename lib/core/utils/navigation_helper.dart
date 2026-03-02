import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ai_expense_tracker/core/routes/app_routes.dart';

class NavigationHelper {
  NavigationHelper._();

  static Future<void> toOnboarding(
    BuildContext context, {
    bool replace = false,
  }) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
    return Navigator.pushNamed(context, AppRoutes.onboarding);
  }

  /// Navigates to the login screen.
  static Future<void> toLogin(BuildContext context, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
    return Navigator.pushNamed(context, AppRoutes.login);
  }

  static Future<void> toMain(
    BuildContext context, {
    bool replace = false,
    required UserModel user,
  }) {
    if (replace) {
      return Navigator.pushReplacementNamed(
        context,
        AppRoutes.main,
        arguments: user,
      );
    }
    return Navigator.pushNamed(context, AppRoutes.main, arguments: user);
  }

  static Future<void> toHome(
    BuildContext context, {
    bool replace = false,
    required UserModel user,
  }) {
    if (replace) {
      return Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: user,
      );
    }
    return Navigator.pushNamed(context, AppRoutes.home, arguments: user);
  }

  static Future<void> toTransactions(
    BuildContext context, {
    bool replace = false,
  }) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.transactions);
    }
    return Navigator.pushNamed(context, AppRoutes.transactions);
  }

  static Future<void> toAiChat(BuildContext context, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.aiChat);
    }
    return Navigator.pushNamed(context, AppRoutes.aiChat);
  }

  static Future<void> toReports(BuildContext context, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.reports);
    }
    return Navigator.pushNamed(context, AppRoutes.reports);
  }
}
