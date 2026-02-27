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
}
