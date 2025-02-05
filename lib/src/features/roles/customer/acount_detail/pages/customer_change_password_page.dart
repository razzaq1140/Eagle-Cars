import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:eagle_cars/src/features/auth/customer_auth/customer_forget_password/pages/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/global_variable.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: textTheme(context).headlineMedium?.copyWith(
                    fontSize: 24,
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: currentPasswordController,
                validator: (value) => Validation.passwordValidation(value),
                hint: 'Enter Current Password',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomTextFormField(
                  controller: newPasswordController,
                  validator: (value) => Validation.passwordValidation(value),
                  hint: 'Create New Password',
                ),
              ),
              CustomTextFormField(
                controller: confirmPasswordController,
                validator: (value) => Validation.confirmPasswordValidation(value,newPasswordController.text),
                hint: 'Confirm New Password',
              ),
              const SizedBox(
                height: 100,
              ),
              CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.pop();
                    }
                  },
                  text: 'Save Changes')
            ],
          ),
        ),
      ),
    );
  }
}
