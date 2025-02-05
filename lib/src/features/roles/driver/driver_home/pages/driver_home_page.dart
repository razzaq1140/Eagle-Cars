import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../../common/controllers/driver_google_map_controller.dart';
import '../../../../../common/utils/permission_helper.dart';
import '../controller/driver_home_controller.dart';
import '../widgets/driver_location_bottom_sheet.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  late DriverHomeController driverHomeController;
  late DriverGoogleMapController? driverGoogleMapController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    driverGoogleMapController =
        Provider.of<DriverGoogleMapController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkPermissions();
      await getInitialvalue();
    });
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

    if (status.isGranted) {
      driverHomeController =
          Provider.of<DriverHomeController>(context, listen: false);
      driverHomeController.getPermission(context);

      getInitialvalue();
      setState(() {}); // Trigger a rebuild after initialization
    } else {
      context.pushReplacementNamed(AppRoute.locationDeniedPage);
    }
  }

  getInitialvalue() async {
    await driverGoogleMapController?.getCurrentLocation();
    await driverGoogleMapController?.setCurrentLocationMarker();
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme(context).onSurface,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onSurface,
        leading: null,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(AppRoute.driverProfilePage),
              child: ClipOval(
                child: Image.network(
                  width: 40,
                  height: 40,
                  NetworkImages.profileImage,
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
            onTap: () => context.pushNamed(AppRoute.driverNotificationPage),
            child: Badge(child: SvgPicture.asset(AppIcons.bellIcon)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => context.pushNamed(AppRoute.driverSettingPage),
              child: SvgPicture.asset(AppIcons.appbarSettingsIcon),
            ),
          ),
        ],
      ),
      body: driverGoogleMapController == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading until initialized
          : Stack(
              children: [
                Consumer<DriverGoogleMapController>(
                    builder: (context, controller, widget) {
                  if (controller.currentLatLng == null) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator jab tak location null hai
                  }
                  return SizedBox(
                    height: height,
                    width: width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            onMapCreated: controller.setController,
                            initialCameraPosition: CameraPosition(
                              target: controller.currentLatLng ??
                                  controller.initialPosition,
                              zoom: 14.0,
                            ),
                            markers: controller.markers,
                            circles: <Circle>{
                              Circle(
                                circleId: const CircleId("currentLocation"),
                                center: LatLng(controller.currentLatLng!.latitude,
                                    controller.currentLatLng!.longitude),
                                radius: 100, // radius in meters
                                fillColor: colorScheme(context)
                                    .primary
                                    .withOpacity(0.5), // light color
                                strokeColor: colorScheme(context).primary,
                                strokeWidth: 2,
                              ),
                            },
                            myLocationEnabled: false,
                            myLocationButtonEnabled: true,
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                          ),
                          Positioned(
                            bottom: 200,
                            right: 12,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: FloatingActionButton(
                                shape:  CircleBorder(),
                                onPressed: () async {
                                  if (driverGoogleMapController?.currentLatLng != null) {
                                    // Animate camera to current location
                                    driverGoogleMapController?.mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: driverGoogleMapController!.currentLatLng!,
                                          zoom: 14.0, // Adjust zoom level as needed
                                        ),
                                      ),
                                    );
                                  }
                                },
                                // onPressed: controller.fetchCurrentLocation,
                                backgroundColor: colorScheme(context).surface,
                                child: Icon(Icons.my_location,
                                    color: colorScheme(context).onSurface),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DriverLocationBottomSheet()),
                Positioned(
                    bottom: height * 0.25,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.driverRequestPage);
                      },
                      child: CircleAvatar(
                        backgroundColor: colorScheme(context).onSurface,
                        radius: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.driverPersonIcon),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Hail ride',
                              style: textTheme(context).bodySmall!.copyWith(
                                  color: colorScheme(context).surface,
                                  letterSpacing: 0),
                            )
                          ],
                        ),
                      ),
                    )),

              ],
            ),
    );
  }
}
