import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/controllers/my_google_map_controller.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CustomerRideTrackingPage extends StatefulWidget {
  const CustomerRideTrackingPage({super.key});

  @override
  State<CustomerRideTrackingPage> createState() =>
      _CustomerRideTrackingPageState();
}

class _CustomerRideTrackingPageState extends State<CustomerRideTrackingPage> {
  late MyGoogleMapController googleProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      googleProvider =
          Provider.of<MyGoogleMapController>(context, listen: false);
      googleProvider.setSearchLocation(googleProvider.searchLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ride Tracking',
                style: textTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
            InkWell(
              onTap: () {
                context.pushNamed(AppRoute.customerDriverProfilePage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(NetworkImages.profileImage),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Albert Flores',
                          style: textTheme(context).labelMedium!.copyWith(
                              color: colorScheme(context)
                                  .onPrimary
                                  .withOpacity(0.7),
                              letterSpacing: 0)),
                      Text('Toyota Prius - Black',
                          style: textTheme(context).labelMedium!.copyWith(
                              color: colorScheme(context).outline,
                              letterSpacing: 0)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: colorScheme(context).primary,
                          ),
                          Text.rich(TextSpan(
                              text: '4.8',
                              style: textTheme(context).titleMedium!.copyWith(
                                  color: colorScheme(context)
                                      .onPrimary
                                      .withOpacity(0.5)),
                              children: [
                                TextSpan(
                                    text: '(review) 1k',
                                    style: textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                            color: colorScheme(context).outline,
                                            letterSpacing: 0))
                              ]))
                        ],
                      ),
                      Text.rich(TextSpan(
                          text: '[License Plate]',
                          style: textTheme(context).labelMedium!.copyWith(
                              color: colorScheme(context)
                                  .onPrimary
                                  .withOpacity(0.5)),
                          children: [
                            TextSpan(
                                text: 'ABC123',
                                style: textTheme(context).bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme(context).onPrimary,
                                    letterSpacing: 0))
                          ]))
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: colorScheme(context).outline,
            ),
            const SizedBox(
              height: 12,
            ),
            Text('Vehicle Information',
                style: textTheme(context).labelMedium!.copyWith(
                    color: colorScheme(context).onPrimary.withOpacity(0.7),
                    letterSpacing: 0)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toyota Prius-Black',
                  style: textTheme(context).labelMedium!.copyWith(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      color: colorScheme(context).outline),
                ),
                Text(
                  'License Plate: ABC 1234',
                  style: textTheme(context).labelMedium!.copyWith(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      color: colorScheme(context).onPrimary),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Divider(
              color: colorScheme(context).outline,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.customerChatPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colorScheme(context).primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(4),
                          bottomLeft: Radius.circular(10),
                        )),
                    child: SvgPicture.asset(AppIcons.sms),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(4),
                        bottomLeft: Radius.circular(10),
                      )),
                  child: const Icon(
                    CupertinoIcons.phone,
                  ),
                )
              ],
            ),
            Text('Current Location',
                style: textTheme(context).labelMedium!.copyWith(
                    color: colorScheme(context).onPrimary.withOpacity(0.7),
                    letterSpacing: 0)),
            const SizedBox(
              height: 12,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 264,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Consumer<MyGoogleMapController>(
                  builder: (context, mapController, child) {
                    // LatLng? currentLocation = mapController.currentLatLng;
                    // if (currentLocation == null) {
                    //   return const Center(child: CircularProgressIndicator());
                    // }
                    // final List<LatLng> polylinePoints = [
                    //   currentLocation,
                    //   destination,
                    // ];

                    // final Set<Polyline> polylines = {
                    //   Polyline(
                    //     polylineId: const PolylineId('route1'),
                    //     points: polylinePoints,
                    //     color: Colors.blue,
                    //     width: 5,
                    //   ),
                    // };

                    return GoogleMap(
                      onMapCreated: mapController.setController,
                      initialCameraPosition: CameraPosition(
                        target: mapController.currentLatLng ??
                            mapController.initialPosition,
                        zoom: 14.0,
                      ),
                      markers: mapController.markers,
                      myLocationEnabled: false,
                      polylines: mapController.currentPolylines,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
