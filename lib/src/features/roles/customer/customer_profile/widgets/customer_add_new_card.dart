import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/utils/validations.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
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
                    'Add New Card',
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                validator: (value) =>
                    Validation.fieldValidation(value, 'Card Number'),
                hint: 'Card Number',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                validator: (value) =>
                    Validation.fieldValidation(value, 'Account Holder Name'),
                hint: 'Account Holder Name',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      validator: (value) =>
                          Validation.fieldValidation(value, 'Expiry date'),
                      hint: 'Expiry date',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFormField(
                      validator: (value) =>
                          Validation.fieldValidation(value, 'CVV'),
                      hint: 'CVV',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('object');
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
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
