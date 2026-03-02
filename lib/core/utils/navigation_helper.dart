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

  static Future<void> toMain(BuildContext context, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.main);
    }
    return Navigator.pushNamed(context, AppRoutes.main);
  }

  static Future<void> toHome(BuildContext context, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
    return Navigator.pushNamed(context, AppRoutes.home);
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
