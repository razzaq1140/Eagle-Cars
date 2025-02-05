import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eagle_cars/src/common/utils/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/controllers/my_google_map_controller.dart';
import '../../../../../router/routes.dart';
import '../controller/customer_home_controller.dart';
import '../widgets/location_bottom_sheet.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  late CustomerHomeController customerHomeProvider;
  MyGoogleMapController? customerMapController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    customerMapController =
        Provider.of<MyGoogleMapController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkPermissions();
      await customerMapController?.setCurrentLocationMarker();
    });

    // Listen to connectivity changes
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showInternetDialog();
      } else {
        _closeInternetDialog();
      }
    });
  }

  Future<void> _checkPermissions() async {
    // Request location permission
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      // Initialize controllers and load data if permission is granted
      customerHomeProvider =
          Provider.of<CustomerHomeController>(context, listen: false);
      customerHomeProvider.getPermission(context);

      customerMapController?.setCurrentLocationMarker();

      setState(() {}); // Trigger a rebuild after initialization
    } else {
      // Navigate to PermissionDeniedPage if permission is denied
      context.pushReplacementNamed(AppRoute.locationDeniedPage);
    }
  }

  // Show Internet dialog
  void _showInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text("No Internet Connection"),
            content: const Text("Please connect to the internet to continue."),
            actions: [
              TextButton(
                child: const Text("Retry"),
                onPressed: () async {
                  bool hasInternet =
                      await PermissionHelper.checkInternetConnection();
                  if (hasInternet) {
                    _closeInternetDialog();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Close Internet dialog if it is open
  void _closeInternetDialog() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription
        .cancel(); // Cancel the subscription when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: colorScheme(context).onSurface,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onSurface,
        leading: null,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(AppRoute.customerProfilePage),
              child: ClipOval(
                child: Image.network(
                  NetworkImages.profileImage,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported_outlined),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: colorScheme(context).surface),
                ),
                Text(
                  'John Doe',
                  style: textTheme(context)
                      .bodySmall
                      ?.copyWith(color: colorScheme(context).surface),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => context.pushNamed(AppRoute.customerNotificationPage),
            child: SvgPicture.asset(AppIcons.bellIcon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => context.pushNamed(AppRoute.customerSettingPage),
              child: SvgPicture.asset(AppIcons.appbarSettingsIcon),
            ),
          ),
        ],
      ),
      body: customerMapController == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading until initialized
          : Consumer<MyGoogleMapController>(
              builder: (context, controller, widget) {
                if (controller.currentLatLng == null) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Loading indicator jab tak location null hai
                }
                return Container(
                  height: height,
                  width: width,
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: controller.setController,
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(
                                37.7749, -122.4194), // Placeholder coordinates
                            zoom: 14.0,
                          ),
                          myLocationEnabled: false,
                          myLocationButtonEnabled:
                              false, // Disable default button
                          compassEnabled: true,
                          zoomControlsEnabled: false,
                          markers: customerMapController!.markers,
                          circles: customerMapController!.circles,
                        ),
                        Positioned(
                          bottom: 270,
                          right: 16,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              shape: const CircleBorder(),
                              onPressed: controller.fetchCurrentLocation,
                              backgroundColor: colorScheme(context).surface,
                              child: Icon(Icons.my_location,
                                  color: colorScheme(context).onSurface),
                            ),
                          ),
                        ),
                        const LocationBottomSheet(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
