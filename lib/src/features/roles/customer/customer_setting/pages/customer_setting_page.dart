import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../driver/driver_setting/model/setting_model.dart';

class CustomerSettingPage extends StatelessWidget {
  CustomerSettingPage({super.key});

  final List<SettingModel> settingModel = [
    SettingModel(
      navRoute: AppRoute.customerAccountDetailPage,
      type: "Profile Management",
      title: "Update name, email, phone number, driver_profile photo",
      icon: AppIcons.person, // Replace with actual icons
    ),
    SettingModel(
      navRoute: "",
      type: "Notifications Settings",
      title: "Manage your driver_notification preferences.",
      icon: AppIcons.settingsBellIcon,
    ),
    SettingModel(
      navRoute: "",
      type: "Payment Settings",
      title: "Manage your saved customer_payment methods",
      icon: AppIcons.payment,
    ),
    SettingModel(
      navRoute: AppRoute.customerSupportPage,
      type: "Help & Support",
      title: "Access FAQs, contact support, or send feedback",
      icon: AppIcons.paymentIcon,
    ),
    SettingModel(
      navRoute: "",
      type: "Legal Information",
      title: "Terms & conditions, privacy policy, app version",
      icon: AppIcons.informationIcon,
    ),
    SettingModel(
      navRoute: "",
      type: "Language",
      title: "Language, theme, and other preferences",
      icon: AppIcons.language,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: textTheme(context).headlineMedium?.copyWith(
                  fontSize: 24,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: settingModel.length,
                itemBuilder: (context, index) {
                  final setting = settingModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        if (setting.navRoute.isNotEmpty) {
                          context.pushNamed(setting.navRoute);
                        }
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(2),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(2))),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: colorScheme(context)
                                            .primary
                                            .withOpacity(0.1),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(2),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(2))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        setting.icon,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    setting.type,
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                setting.title,
                                style: textTheme(context).bodyLarge?.copyWith(
                                    fontSize: 14,
                                    color: colorScheme(context)
                                        .onSurface
                                        .withOpacity(0.4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
