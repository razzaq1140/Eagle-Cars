import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';
import '../../../../../router/routes.dart';

class DriverForgetPasswordPage extends StatefulWidget {
  const DriverForgetPasswordPage({super.key});

  @override
  State<DriverForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<DriverForgetPasswordPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                Text('Forgot Password',
                    style: textTheme(context)
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
                const SizedBox(height: 8),
                Text('Please enter your email to reset the\n password.',
                    style: textTheme(context).bodyLarge!.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                          letterSpacing: 0,
                          fontSize: 17,
                        )),
                const SizedBox(height: 40),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'Enter your Email',
                  validator: (value) => Validation.emailValidation(value),
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        context.pushNamed(AppRoute.driverVerificationPage);
                      }
                    },
                    text: 'Next'),
              ],
            )),
      ),
    );
  }
}
