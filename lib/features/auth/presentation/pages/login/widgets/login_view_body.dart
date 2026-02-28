import 'package:ai_expense_tracker/core/utils/navigation_helper.dart';
import 'package:ai_expense_tracker/core/utils/size_config.dart';
import 'package:ai_expense_tracker/core/widgets/custom_buttons.dart';
import 'package:ai_expense_tracker/core/widgets/custom_line.dart';
import 'package:ai_expense_tracker/core/widgets/space.dart';
import 'package:ai_expense_tracker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:ai_expense_tracker/features/auth/presentation/pages/login/widgets/login_form_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          NavigationHelper.toHome(context, replace: true);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalSpace(8),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.screenWidth! * 0.2,
                      child: Image.asset('assets/images/app_logo.png'),
                    ),
                  ),
                  const VerticalSpace(1.5),
                  Text(
                    'Track every pound. Grow every day. 💜',
                    style: TextStyle(
                      fontSize: 20,
                      color: colors.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalSpace(5),
                  IgnorePointer(
                    ignoring: isLoading,
                    child: Form(
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
                          const VerticalSpace(2.5),
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
                          const VerticalSpace(2.5),
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
                  ),
                  const VerticalSpace(3),
                  CustomGenralButton(
                    isLoading: isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<AuthCubit>().emailSignIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          name: nameController.text.trim(),
                        );
                      }
                    },
                  ),
                  const VerticalSpace(1.5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLine(),
                      Text(' Or ', style: TextStyle(fontSize: 16)),
                      CustomLine(),
                    ],
                  ),
                  const VerticalSpace(1.5),
                  CustomLoginWithButton(
                    isLoading: isLoading,
                    text: 'Login with Google',
                    imagePath: 'assets/images/google_icon.png',
                    onTap: () => context.read<AuthCubit>().googleSignIn(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
