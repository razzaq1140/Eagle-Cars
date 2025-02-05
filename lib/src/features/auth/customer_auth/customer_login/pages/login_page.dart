import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';
import '../../../../../router/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login To Account',
                    style: textTheme(context)
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'Email or Phone Number',
                  validator: (value) => Validation.emailOrPhoneValidation(value),
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  validator: (value) => Validation.passwordValidation(value),
                ),
                const SizedBox(height: 6),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          context.pushNamed(AppRoute.forgetPasswordPage);
                        },
                        child: Text('Forgot password?',
                            style: textTheme(context).labelLarge!.copyWith(
                                letterSpacing: 0,
                                decoration: TextDecoration.underline)))),
                const SizedBox(height: 50),
                CustomElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        MyAppRouter.clearAndNavigate(
                            context, AppRoute.customerHomePage);
                      }
                    },
                    text: 'Login'),
                const SizedBox(height: 20),
                Center(
                    child: Text('- or customer_login with -',
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
                          text: 'New user? ',
                          style: textTheme(context)
                              .labelLarge!
                              .copyWith(letterSpacing: 0),
                        ),
                        TextSpan(
                          text: 'Create Account',
                          style: textTheme(context).labelLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: colorScheme(context).primary,
                              letterSpacing: 0,
                              color: colorScheme(context).primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(AppRoute.signUpPage);
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
