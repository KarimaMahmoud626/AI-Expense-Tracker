import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:ai_expense_tracker/features/home/presentation/pages/home_view/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeViewBody(user: user));
  }
}
