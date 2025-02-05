import 'dart:async';
import 'dart:math' show Random;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_request/widgets/accept_custom_bottom_sheet.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_request/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../common/controllers/driver_google_map_controller.dart';

class DriverRequestPage extends StatefulWidget {
  const DriverRequestPage({super.key});

  @override
  State<DriverRequestPage> createState() => _DriverRequestPageState();
}

class _DriverRequestPageState extends State<DriverRequestPage> {
  double rating = Random().nextDouble() * 5.0;

  bool isScanning = false;

  void startScanning() {
    setState(() {
      isScanning = true;
    });
    showRequest();
  }

  void _showInitialBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomBottomSheet(
          rating: rating,
          ontap: () {
            driverGoogleMapController.getCustomerLocation();
            // _startMovement();
            Navigator.of(context).pop(); // Close initial bottom sheet
            customSheet();
          },
        );
      },
    );
  }

  void customSheet() {
    Future.delayed(const Duration(seconds: 5), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => AcceptCustomBottomSheet(
          rating: rating,
          color: colorScheme(context).error,
          onTap: () {
            Navigator.of(context).pop();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              driverGoogleMapController.clearMarkersExceptCurrentLocation();
            });
          },
          showcallchat: true,
        ),
      );
    });
  }

  void showRequest() async {
    await Future.delayed(const Duration(seconds: 5));
    isScanning = false;
    setState(() {});
    _showInitialBottomSheet();
  }

  late DriverGoogleMapController driverGoogleMapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      driverGoogleMapController =
          Provider.of<DriverGoogleMapController>(context, listen: false);
      startScanning();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Consumer<DriverGoogleMapController>(
              builder: (context, controller, widget) {
            if (controller.currentLatLng == null) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Loading indicator jab tak location null hai
            }

            return GoogleMap(
              onMapCreated: controller.setController,
              initialCameraPosition: CameraPosition(
                target: controller.currentLatLng ?? controller.initialPosition,
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
              polylines: controller.currentPolylines,
              myLocationEnabled: false,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
            );
          }),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: colorScheme(context).onPrimary,
                      child: Icon(
                        Icons.arrow_back,
                        color: colorScheme(context).surface,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: colorScheme(context).onPrimary,
                    backgroundImage: const CachedNetworkImageProvider(
                        NetworkImages.profileImage),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: isScanning ? height * 0.1 : 16,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                startScanning();
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
            ),
          ),
          if (isScanning)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )),
                child: Center(
                  child: Text(
                    'Scanning...',
                    style: textTheme(context)
                        .titleMedium!
                        .copyWith(color: colorScheme(context).surface),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
