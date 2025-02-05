import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverUpdatePasswordPage extends StatefulWidget {
  const DriverUpdatePasswordPage({super.key});

  @override
  State<DriverUpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<DriverUpdatePasswordPage> {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update Password',
                    style: textTheme(context)
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                    'Create a new password. Ensure it differs\n from previous ones for security',
                    style: textTheme(context).bodyLarge!.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                          letterSpacing: 0,
                          fontSize: 17,
                        )),
                const SizedBox(height: 50),
                CustomTextFormField(
                  controller: newPasswordController,
                  hint: 'Enter new password',
                  validator: (value) => Validation.passwordValidation(value),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: confirmNewPasswordController,
                  hint: 'Confirm new password',
                  validator: (value) => Validation.confirmPasswordValidation(value, newPasswordController.text),
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        context.pushNamed(AppRoute.driverSuccessfullyPage);
                      }
                    },
                    text: 'Next'),
              ],
            )),
      ),
    );
  }
}
