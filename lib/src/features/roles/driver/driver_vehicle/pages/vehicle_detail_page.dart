import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '/src/common/constants/app_images.dart';
import '/src/common/constants/global_variable.dart';
import '/src/common/widgets/custom_elevated_button.dart';
import '../../../../../common/utils/validations.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';
import '../widgets/image_picker_dialog.dart';

class DriverVehicleDetailPage extends StatefulWidget {
  const DriverVehicleDetailPage({super.key});

  @override
  State<DriverVehicleDetailPage> createState() =>
      _DriverVehicleDetailPageState();
}

class _DriverVehicleDetailPageState extends State<DriverVehicleDetailPage> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

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
  void initState() {
    super.initState();
    brandController.text = 'Toyota';
    modelController.text = 'Camry';
    colorController.text = 'White';
    yearController.text = '2006';
    plateNumberController.text = 'BD51SMR';
  }

  bool isUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicle Details',
                style: textTheme(context).headlineMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
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
                        ? Center(
                            child: CachedNetworkImage(
                              imageUrl: NetworkImages.carImage,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          )
                        : Image.file(
                            height: 168,
                            width: double.infinity,
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _showImagePickerDialog,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: colorScheme(context).primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: brandController,
                onChanged: (value) {
                  setState(() {
                    isUpdated = true; // Track update
                  });
                },
                validator: (value) =>
                    Validation.fieldValidation(value, 'Vehicle brand'),
                hint: 'Vehicle brand',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomTextFormField(
                  controller: modelController,
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Model'),
                  hint: 'Model',
                ),
              ),
              CustomTextFormField(
                controller: colorController,
                onChanged: (value) {
                  setState(() {
                    isUpdated = true; // Track update
                  });
                },
                validator: (value) =>
                    Validation.fieldValidation(value, 'Color'),
                hint: 'Color',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomTextFormField(
                  controller: yearController,
                  onChanged: (value) {
                    setState(() {
                      isUpdated = true; // Track update
                    });
                  },
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Year'),
                  hint: 'Year',
                ),
              ),
              CustomTextFormField(
                controller: plateNumberController,
                onChanged: (value) {
                  setState(() {
                    isUpdated = true; // Track update
                  });
                },
                validator: (value) =>
                    Validation.fieldValidation(value, 'Plate Number'),
                hint: 'Plate Number',
              ),
              const SizedBox(height: 20),
              // CustomElevatedButton(
              //   onPressed: () {
              //     if (!_formKey.currentState!.validate()) {
              //       // Form validation fail
              //       showSnackbar(message: 'Please fix errors in the form.');
              //       return;
              //     }
              //
              //     // Snackbar logic
              //     if (isUpdated) {
              //       showSnackbar(message: 'Data has been updated successfully.');
              //     } else {
              //       showSnackbar(message: 'No changes were made.');
              //     }
              //
              //     // Reset state after saving
              //     setState(() {
              //       isUpdated = false;
              //     });
              //   },
              //   text: 'Save',
              // ),
              CustomElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    showSnackbar(message: 'Please fix errors in the form.');
                    return;
                  }
                  if (isUpdated) {
                    showSnackbar(message: 'Data has been updated successfully.');
                    context.pop();
                  } else {
                    showSnackbar(message: 'Data has been not updated');
                    context.pop();
                  }

                  // Reset state after saving
                  setState(() {
                    isUpdated = false;
                  });
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
