import 'dart:io';
import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '/src/common/constants/app_images.dart';
import '/src/common/constants/global_variable.dart';
import '/src/common/widgets/custom_elevated_button.dart';
import '../../../../../router/routes.dart';
import '../widgets/image_picker_dialog.dart';

class DriverAddVehiclePage extends StatefulWidget {
  const DriverAddVehiclePage({super.key});

  @override
  State<DriverAddVehiclePage> createState() => _DriverAddVehiclePageState();
}

class _DriverAddVehiclePageState extends State<DriverAddVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final TextEditingController yearController = TextEditingController();
  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (!mounted) return;

    if (status.isGranted) {
      setState(() {}); // UI update karo agar permission granted ho
    } else {
      if (!mounted) return; // Phir check karo ke widget mounted hai ya nahi
      context.pushReplacementNamed(AppRoute.locationDeniedPage); // PermissionDeniedPage pr navigate karo
    }
  }

  // Image picker dialog dikhane ka function
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => ImagePickerDialog(
        onCameraTap: () async {
          final pickedFile = await _picker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile; // Camera se selected image set karo
            });
          }
          Navigator.pop(context);
        },
        onGalleryTap: () async {
          final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile; // Gallery se selected image set karo
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return; // Ensure karo ke widget mounted hai
      await _checkPermissions(); // Permissions check karo
    });
  }

  @override
  void dispose() {
    yearController.dispose(); // Controller dispose karo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Vehicle',
                style: textTheme(context).headlineMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _showImagePickerDialog, // Image picker dialog show karo
                child: Container(
                  height: 250,
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
                              AppIcons.addVehicle, // Placeholder icon
                              fit: BoxFit.fill,
                            ),
                          )),
                      const SizedBox(height: 20),
                      Text(
                        'Upload Photo',
                        style: textTheme(context).titleMedium?.copyWith(
                            fontSize: 16,
                            color: colorScheme(context).onSurface),
                      )
                    ],
                  )
                      : Image.file(
                    File(_selectedImage!.path), // Selected image dikhaye
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                validator: (value) => Validation.fieldValidation(value, 'Vehicle brand'),
                hint: 'Vehicle brand',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomTextFormField(
                  validator: (value) => Validation.fieldValidation(value, 'Model'),
                  hint: 'Model',
                ),
              ),
              CustomTextFormField(
                validator: (value) => Validation.fieldValidation(value, 'Color'),
                hint: 'Color',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      yearController.text = selectedDate.year.toString(); // Selected year set karo
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: yearController,
                      validator: (value) => Validation.fieldValidation(value, 'Year'),
                      hint: 'Year',
                    ),
                  ),
                ),
              ),
              CustomTextFormField(
                validator: (value) => Validation.fieldValidation(value, 'Plate Number'),
                hint: 'Plate Number',
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
MyAppRouter.clearAndNavigate(context, AppRoute.driverHomePage); // DriverHomePage pr navigate karo
                  }
                },
                text: 'Add Vehicle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
