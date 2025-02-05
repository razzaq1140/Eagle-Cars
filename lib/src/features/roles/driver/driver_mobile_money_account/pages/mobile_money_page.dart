import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:eagle_cars/src/features/auth/customer_auth/customer_forget_password/pages/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/global_variable.dart';

class MobileMoneyPage extends StatefulWidget {
  const MobileMoneyPage({super.key});

  @override
  State<MobileMoneyPage> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<MobileMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
            MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures the sheet wraps content
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Add Mobile Money Account',
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    Validation.phoneNumberValidation(value,),
                hint: 'Phone Number',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Regional Code'),
                hint: 'Regional Code',
              ),
              const SizedBox(height: 100),
              CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.pop();
                    }
                  },
                  text: 'Save'),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: colorScheme(context).primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 54),
            ],
          ),
        ),
      ),
    );
  }
}
