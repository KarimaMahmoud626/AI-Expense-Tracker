import 'package:ai_expense_tracker/core/utils/size_config.dart';
import 'package:ai_expense_tracker/core/widgets/custom_buttons.dart';
import 'package:ai_expense_tracker/core/widgets/custom_line.dart';
import 'package:ai_expense_tracker/core/widgets/space.dart';
import 'package:ai_expense_tracker/features/auth/presentation/pages/login/widgets/login_form_item.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth! * 0.2,
                  child: Image.asset('assets/images/app_logo.png'),
                ),
              ),
              HorizontalSpace(1.5),
              Text(
                'Track every pound. \nGrow every day. 💜',
                style: TextStyle(
                  fontSize: 20,
                  color: colors.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          VerticalSpace(5),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginFormItem(
                  text: 'Full Name',
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(2.5),
                LoginFormItem(
                  text: 'Email Address',
                  icon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (!value.contains('@')) return 'Invalid email';
                    return null;
                  },
                ),
                VerticalSpace(2.5),
                LoginFormItem(
                  text: 'Password',
                  controller: passwordController,
                  icon: Icons.lock_rounded,
                  suffixIcon: Icons.visibility_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Required Field'
                              : null,
                ),
              ],
            ),
          ),
          VerticalSpace(3),
          CustomGenralButton(onTap: () {}),
          VerticalSpace(1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLine(),
              Text(' Or ', style: TextStyle(fontSize: 16)),
              CustomLine(),
            ],
          ),
          VerticalSpace(1.5),
          CustomLoginWithButton(
            text: 'Login with Google',
            imagePath: 'assets/images/google_icon.png',
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
