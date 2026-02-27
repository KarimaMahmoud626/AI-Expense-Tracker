import 'package:ai_expense_tracker/core/utils/navigation_helper.dart';
import 'package:ai_expense_tracker/core/utils/size_config.dart';
import 'package:ai_expense_tracker/core/widgets/custom_buttons.dart';
import 'package:ai_expense_tracker/core/widgets/space.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Spacer(flex: 2),
        Center(
          child: SizedBox(
            width: SizeConfig.screenWidth! * 0.85,
            child: Image.asset('assets/images/onboarding.png'),
          ),
        ),
        Spacer(flex: 1),
        Text(
          'Grow Your Savings,\n  One Step at a Time',
          style: TextStyle(
            fontSize: 36,
            color: colors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'See your progress, get reminders, and start building the habbits that lead to financial freedom',
          style: TextStyle(
            color: colors.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 1),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.85,
          child: CustomGenralButton(
            text: 'Get Started',
            onTap: () {
              NavigationHelper.toLogin(context, replace: true);
            },
          ),
        ),
        VerticalSpace(5),
      ],
    );
  }
}
