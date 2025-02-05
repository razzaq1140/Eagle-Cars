import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/utils/custom_clipper.dart';
import '../../../../../router/routes.dart';
import '../../driver_vehicle/widgets/image_picker_dialog.dart';
import '../widgets/driver_manage_debit_card.dart';
import '../widgets/driver_profile_wallet_bottom_sheet.dart';
import '../widgets/driver_top_up_bottom_sheet.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

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

  void _showWalletBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme(context).surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DriverWalletBottomSheet();
      },
    );
  }

  /*void _showTopUpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme(context).surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DriverTopUpBottomSheet(
          amountController: _amountController,
          bankCardController: _bankCardController,
          newCardController: _newCardController,
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: height * 0.3,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      color: colorScheme(context).surface,
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.08,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Balance',
                        style: textTheme(context).headlineMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colorScheme(context).surface,
                              fontSize: 12,
                            ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _showWalletBottomSheet(context),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme(context).primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'USD',
                                style: TextStyle(
                                    color: colorScheme(context).onSurface,
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '240.000',
                              style:
                                  textTheme(context).headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme(context).surface,
                                        fontSize: 20,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height * 0.08,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => const DriverTopUpBottomSheet());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Top Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.14),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: _selectedImage == null
                            ? const NetworkImage(NetworkImages.carImage)
                            : FileImage(File(_selectedImage!.path))
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: GestureDetector(
                          onTap: _showImagePickerDialog,
                          child: CircleAvatar(
                            backgroundColor: colorScheme(context).primary,
                            radius: 16,
                            child: const Icon(Icons.edit,
                                color: Colors.black, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Sule Abdul',
                      style: textTheme(context).titleLarge?.copyWith(
                          color: colorScheme(context).onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Text(
                    'abdulsule@mail.com',
                    style: textTheme(context).titleLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuItem(
                    onTap: () => context.pushNamed(AppRoute.driverSettingPage),
                    iconWidget: Icon(Icons.settings,
                        color: colorScheme(context).primary),
                    label: 'Account settings',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.driverChangePasswordPage),
                    iconWidget:
                        Icon(Icons.lock, color: colorScheme(context).primary),
                    label: 'Change Password',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.driverBookingHistoryPage),
                    iconWidget: Icon(Icons.history,
                        color: colorScheme(context).primary),
                    label: 'Booking History',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.driverVehicleDetailPage),
                    iconWidget: Icon(Icons.directions_car,
                        color: colorScheme(context).primary),
                    label: 'Vehicle details',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            const DriverManageDebitCardsSheet(),
                      );
                    },
                    iconWidget: Icon(Icons.credit_card,
                        color: colorScheme(context).primary),
                    label: 'Card and bank settings',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () => context.pushNamed(AppRoute.driverSupportPage),
                    iconWidget: Icon(Icons.support_agent,
                        color: colorScheme(context).primary),
                    label: 'Customer support',
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      MyAppRouter.clearAndNavigate(context, AppRoute.rolePage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: colorScheme(context).primary),
                        const SizedBox(width: 8),
                        Text('Sign out',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).primary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required Widget iconWidget,
    required String label,
    required BuildContext context,
    required void Function() onTap,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: iconWidget,
          title: Text(
            label,
            style: textTheme(context)
                .titleMedium
                ?.copyWith(color: colorScheme(context).onSurface, fontSize: 16),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: colorScheme(context).primary, size: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(color: colorScheme(context).primary),
        )
      ],
    );
  }
}
