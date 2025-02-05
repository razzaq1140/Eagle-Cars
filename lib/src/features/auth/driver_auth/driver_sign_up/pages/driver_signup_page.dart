import 'dart:io';

import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';
import '../../../../../router/routes.dart';
import '../../../../roles/driver/driver_vehicle/widgets/image_picker_dialog.dart';

class DriverSignupPage extends StatefulWidget {
  const DriverSignupPage({super.key});

  @override
  State<DriverSignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<DriverSignupPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => ImagePickerDialog(
        onCameraTap: () async {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile;
            });
          }
          Navigator.pop(context);
        },
        onGalleryTap: () async {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile;
            });
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
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
                  keyboardType: TextInputType.phone,
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
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: _showImagePickerDialog,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme(context).surface,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme(context).outline.withOpacity(0.4),
                          offset: const Offset(3, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SvgPicture.asset(
                                  AppIcons.addVehicle,
                                  fit: BoxFit.fill,
                                ),
                              )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Upload Photo',
                                style: textTheme(context).titleMedium?.copyWith(
                                    fontSize: 16,
                                    color: colorScheme(context).onSurface),
                              )
                            ],
                          )
                        : Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomElevatedButton(
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        MyAppRouter.clearAndNavigate(
                            context, AppRoute.driverAddVehiclePage);
                      }
                    },
                    text: 'Create Account'),
                const SizedBox(height: 20),
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
                              context.pushNamed(AppRoute.driverLoginPage);
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
