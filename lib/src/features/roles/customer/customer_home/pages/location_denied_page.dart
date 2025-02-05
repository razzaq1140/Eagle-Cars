import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '/src/common/widgets/custom_elevated_button.dart';
import '../../../../../router/routes.dart';
import '../controller/customer_home_controller.dart';

class LocationDeniedPage extends StatefulWidget {
  const LocationDeniedPage({super.key});

  @override
  State<LocationDeniedPage> createState() => _LocationDeniedPageState();
}

class _LocationDeniedPageState extends State<LocationDeniedPage> {
  Future<void> _requestPermission(BuildContext context) async {
    // Request location permission
    var status = await Permission.location.request();

    // Check the permission status
    if (status.isGranted) {
      // If permission is granted, navigate to CustomerHomePage
      context.pushReplacementNamed(AppRoute.customerHomePage);
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, show a SnackBar with a settings option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Location permission is permanently denied. Please enable it from settings."),
          action: SnackBarAction(
            backgroundColor: colorScheme(context).primary,
            label: "Settings",
            onPressed: () async {
              await openAppSettings(); // Open app settings
            },
          ),
        ),
      );
    } else {
      // If permission is denied temporarily, show a SnackBar message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location permission is required to proceed."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Location Permission'),
        ),
        body: Consumer<CustomerHomeController>(
          builder: (context, controller, widget) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: controller.locationAllowed == false
                    ? const Text(
                        'Location has been denied permanently. Go to your settings and allow the app to use location.')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Location permission is required to continue.',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomElevatedButton(
                            onPressed: () async {
                              await _requestPermission(context);
                            },
                            text: 'Request Location Permission',
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
