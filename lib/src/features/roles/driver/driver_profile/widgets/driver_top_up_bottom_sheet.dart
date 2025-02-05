import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/global_variable.dart';

class DriverTopUpBottomSheet extends StatefulWidget {
  const DriverTopUpBottomSheet({super.key});

  @override
  State<DriverTopUpBottomSheet> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<DriverTopUpBottomSheet> {
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
                    'Top up',
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Enter Amount'),
                hint: 'Enter Amount',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                readOnly: true,
                hint: 'Use bank card ***** **** 657',
                suffixIcon: Checkbox(
                  value: true,
                  checkColor: colorScheme(context).surface,
                  activeColor: colorScheme(context).primary,
                  onChanged: (bool? value) {},
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Use a new card'),
                hint: 'Use a new card',
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context) ;
                    }
                  },
                  text: 'Proceed'),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
