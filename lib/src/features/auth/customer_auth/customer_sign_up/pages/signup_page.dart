import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';
import '../../../../../router/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create New Account',
                    style: textTheme(context)
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: firstNameController,
                  hint: 'First Name',
                  validator: (value) =>
                      Validation.fieldValidation(value, 'first name'),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: lastNameController,
                  hint: 'Last Name',
                  validator: (value) =>
                      Validation.fieldValidation(value, 'last name'),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'Email',
                  validator: (value) => Validation.emailValidation(value),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: phoneNumberController,
                  hint: 'Phone Number',
                  validator: (value) => Validation.phoneNumberValidation(value),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  validator: (value) => Validation.passwordValidation(value),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
                  validator: (value) => Validation.confirmPasswordValidation(
                      value, passwordController.text),
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        MyAppRouter.clearAndNavigate(
                            context, AppRoute.customerHomePage);
                      }
                    },
                    text: 'Create Account'),
                const SizedBox(height: 20),
                Center(
                    child: Text('- or sign up with -',
                        style: textTheme(context)
                            .labelMedium!
                            .copyWith(letterSpacing: 0))),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customCircleWidget(AppIcons.facebookIcon),
                      customCircleWidget(AppIcons.googleIcon),
                      customCircleWidget(AppIcons.linkDinIcon),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? Login ',
                          style: textTheme(context)
                              .labelLarge!
                              .copyWith(letterSpacing: 0),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: textTheme(context).labelLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: colorScheme(context).primary,
                              letterSpacing: 0,
                              color: colorScheme(context).primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(AppRoute.loginPage);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget customCircleWidget(String icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: colorScheme(context).surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            )
          ]),
      child: Center(
          child: SvgPicture.asset(
        icon,
        height: 30,
        width: 30,
      )),
    );
  }
}
