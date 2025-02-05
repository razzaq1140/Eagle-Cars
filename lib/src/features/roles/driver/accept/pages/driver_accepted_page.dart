import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/controllers/driver_google_map_controller.dart';
import 'package:eagle_cars/src/features/roles/driver/accept/provider/driver_accepted_provider.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class DriverAcceptedPage extends StatefulWidget {
  const DriverAcceptedPage({super.key});

  @override
  State<DriverAcceptedPage> createState() => _DriverAcceptedPageState();
}

class _DriverAcceptedPageState extends State<DriverAcceptedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<DriverAcceptedProvider>(context, listen: false);
      _loadCustomMarker(provider);
      provider.initialize();
    });
  }

  Future<void> _loadCustomMarker(DriverAcceptedProvider provider) async {
    BitmapDescriptor marker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(15, 15)),
      AppImages.currentLocationImage,
    );
    provider.loadCustomMarker(marker);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<DriverAcceptedProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Consumer<DriverGoogleMapController>(
              builder: (context, controller, widget) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      GoogleMap(
                        onMapCreated: controller.setController,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentLatLng ??
                              controller.initialPosition,
                          zoom: 30.0,
                        ),
                        markers: {
                          ...controller.markers,
                          Marker(
                            markerId: const MarkerId("destination"),
                            position: provider.currentLocation,
                            infoWindow: const InfoWindow(title: "Ride request"),
                            icon: provider.customMarker ??
                                BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRed),
                          ),
                        },
                        circles: controller.currentLatLng != null
                            ? <Circle>{
                          Circle(
                            circleId: const CircleId("currentLocation"),
                            center: LatLng(controller.currentLatLng!.latitude,
                                controller.currentLatLng!.longitude),
                            radius: 100,
                            fillColor:
                            colorScheme(context).primary.withOpacity(0.5),
                            strokeColor: colorScheme(context).primary,
                            strokeWidth: 2,
                          ),
                        }
                            : <Circle>{},
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        compassEnabled: true,
                        zoomControlsEnabled: false,
                        polylines: controller.currentLatLng != null
                            ? {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: [
                              controller.currentLatLng!,
                              provider.currentLocation,
                            ],
                            color: colorScheme(context).primary,
                            width: 5,
                          ),
                        }
                            : {},
                      ),
                    ],
                  ),
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
                      context.pop();
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
            bottom: 0,
            left: 0,
            right: 0,
            child: customBottamContainer(provider),
          )
        ],
      ),
    );
  }

  Widget customBottamContainer(DriverAcceptedProvider provider) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: colorScheme(context).onSurface),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  height: 6,
                  width: 35,
                  decoration: BoxDecoration(
                    color: colorScheme(context).outline,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(NetworkImages.profileImage),
                      ),
                      Text(
                        'Alan Sanusi',
                        style: textTheme(context).bodySmall!.copyWith(
                          fontSize: 12,
                          letterSpacing: 0,
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SmoothStarRating(
                        allowHalfRating: true,
                        color: colorScheme(context).primary,
                        size: 20,
                        borderColor: Colors.white,
                        onRatingChanged: (v) {
                          provider.setRating(v);
                        },
                        starCount: 5,
                        rating: provider.rating,
                        filledIconData: Icons.star_rate_rounded,
                        halfFilledIconData: Icons.star_half_rounded,
                        defaultIconData: Icons.star_rate_rounded,
                        spacing: 0.0,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$50.00',
                            style: textTheme(context).titleMedium!.copyWith(
                              letterSpacing: 0,
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '4.5km',
                            style: textTheme(context).titleMedium!.copyWith(
                              letterSpacing: 0,
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      customRow(
                        icon: Icons.location_on,
                        color: colorScheme(context).surface,
                        tittle: '20 Kado street, Ikeja Lagos',
                      ),
                      const SizedBox(height: 10),
                      customRow(
                        icon: Icons.location_on,
                        color: colorScheme(context).primary,
                        tittle: '20 Kado street, Ikeja Lagos',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (!provider.isFinalButtonVisible && !provider.isTripStarted) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorScheme(context).primary.withOpacity(0.4),
                          child: Icon(
                            Icons.phone,
                            color: colorScheme(context).primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoute.customerChatPage);
                          },
                          child: Image.asset(AppImages.chatImage, height: 42),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.toggleFinalButtonVisibility();
                      },
                      child: Container(
                        height: 33,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: provider.isValue ? colorScheme(context).primary : colorScheme(context).error,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            provider.buttonText,
                            style: textTheme(context).bodySmall!.copyWith(
                              fontSize: 12,
                              letterSpacing: 0,
                              color: provider.isValue ? colorScheme(context).onPrimary : colorScheme(context).surface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else if (provider.isFinalButtonVisible) ...[
                GestureDetector(
                  onTap: () {
                    provider.toggleFinalButtonVisibility();
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Start trip',
                      style: textTheme(context).bodySmall!.copyWith(
                        fontSize: 14,
                        color: colorScheme(context).onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else if (provider.isTripStarted) ...[
                // Else block: show final action options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        height: 33,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: colorScheme(context).surface,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                              'Return Trip',
                              style: textTheme(context).bodySmall!.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  color: colorScheme(context).onPrimary,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        DriverGoogleMapController().mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            const CameraPosition(target: LatLng(29.399575, 71.716088), zoom: 30),
                          ),
                        );
                        showAlertDialog();
                      },
                      child: Container(
                        height: 33,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                              'Arrived',
                              style: textTheme(context).bodySmall!.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  color: colorScheme(context).onPrimary,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ],
          ),
        ),
      ),
    );
  }





  Widget customRow({
    required IconData icon,
    required String tittle,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          tittle,
          style: textTheme(context).bodySmall!.copyWith(
              fontSize: 13,
              letterSpacing: 0,
              color: colorScheme(context).surface,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Future showAlertDialog()async{
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check,color: colorScheme(context).primary,size: 150,),
            Text('Trip Finished',style: textTheme(context).titleSmall!.copyWith(letterSpacing: 0,fontWeight: FontWeight.w500,fontSize: 15),),
          ],
        ),
      );
    },);
  }
}
