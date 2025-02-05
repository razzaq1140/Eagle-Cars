import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/utils/custom_clipper.dart';
import '../../../../../router/routes.dart';
import '../widgets/customer_manage_debit_card.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
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
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.14),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          NetworkImages.profileImage,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: colorScheme(context).primary,
                          radius: 16,
                          child: const Icon(Icons.edit,
                              color: Colors.black, size: 16),
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
                  Text('James Aderson',
                      style: textTheme(context).titleLarge?.copyWith(
                          color: colorScheme(context).onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Text(
                    'maryjane@mail.com',
                    style: textTheme(context).titleLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.customerSettingPage),
                    icon: Icons.settings,
                    label: 'Account settings',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.customerChangePasswordPage),
                    icon: Icons.lock,
                    label: 'Change Password',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.customerBookingHistoryPage),
                    icon: Icons.history,
                    label: 'Booking History',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () {
                      showReferBottomSheet(context);
                    },
                    icon: Icons.send,
                    label: 'Refer a friend',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const ManageDebitCardsSheet(),
                      );
                    },
                    icon: Icons.credit_card,
                    label: 'Card and bank settings',
                    context: context,
                  ),
                  _buildMenuItem(
                    onTap: () =>
                        context.pushNamed(AppRoute.customerSupportPage),
                    icon: Icons.support_agent,
                    label: 'Customer support',
                    context: context,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Sign out option
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

  void showReferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Refer a friend via',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(AppIcons.whatsapp, 'WhatsApp'),
                  _buildIconButton(AppIcons.fb, 'Facebook'),
                  _buildIconButton(AppIcons.smsIcon, 'SMS'),
                  _buildIconButton(AppIcons.others, 'Others'),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: textTheme(context).titleMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton(
    String imagePath,
    String label,
  ) {
    return Column(
      children: [
        SvgPicture.asset(imagePath),
        const SizedBox(height: 8),
        Text(
          label,
          style: textTheme(context).labelSmall?.copyWith(
              color: colorScheme(context).onSurface.withOpacity(0.6)),
        ),
      ],
    );
  }

  // Helper method to build each menu item
  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required BuildContext context,
    required void Function() onTap,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: colorScheme(context).primary),
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
          child: Divider(
            color: colorScheme(context).primary,
          ),
        )
      ],
    );
  }
}
