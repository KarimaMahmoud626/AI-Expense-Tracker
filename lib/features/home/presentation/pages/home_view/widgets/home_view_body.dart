import 'package:ai_expense_tracker/core/widgets/space.dart';
import 'package:ai_expense_tracker/core/widgets/user_profile.dart';
import 'package:ai_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:flutter/widgets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [VerticalSpace(1.5), UserProfile(user: user)]),
    );
  }
}
