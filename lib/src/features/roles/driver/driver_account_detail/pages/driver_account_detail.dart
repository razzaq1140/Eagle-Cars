import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:eagle_cars/src/features/auth/customer_auth/customer_forget_password/pages/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/constants/global_variable.dart';

class DriverAccountDetailPage extends StatefulWidget {
  const DriverAccountDetailPage({super.key});

  @override
  State<DriverAccountDetailPage> createState() =>
      _DriverAccountDetailPageState();
}

class _DriverAccountDetailPageState extends State<DriverAccountDetailPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                'Account Details',
                style: textTheme(context).headlineMedium?.copyWith(
                    fontSize: 24,
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                validator: (value) => Validation.fieldValidation(value, 'name'),
                hint: 'FirstName',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomTextFormField(
                  validator: (value) =>
                      Validation.fieldValidation(value, 'name'),
                  hint: 'LastName',
                ),
              ),
              CustomTextFormField(
                validator: (value) => Validation.emailValidation(value),
                hint: 'Email',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) => Validation.phoneNumberValidation(value),
                  hint: 'Phone number',
                ),
              ),
              CustomTextFormField(
                validator: (value) => Validation.passwordValidation(value),
                hint: 'password',
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
