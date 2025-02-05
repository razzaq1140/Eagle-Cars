import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/controllers/my_google_map_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../common/constants/app_images.dart';
import '../../../../../common/utils/custom_clipper.dart';
import '../../../../../router/routes.dart';

class CustomerDriverProfilePage extends StatefulWidget {
  const CustomerDriverProfilePage({super.key});

  @override
  State<CustomerDriverProfilePage> createState() =>
      _CustomerDriverProfilePageState();
}

class _CustomerDriverProfilePageState extends State<CustomerDriverProfilePage> {
  late MyGoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController =
          Provider.of<MyGoogleMapController>(context, listen: false);
      mapController.setSearchLocation(mapController.searchLocation);
    });
  }

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
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: const Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          NetworkImages
                              .profileImage, // Replace with actual image URL
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Sule Abdul',
                    style: textTheme(context).titleMedium!.copyWith(
                        letterSpacing: 0, fontWeight: FontWeight.w700),
                  )),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: colorScheme(context).primary,
                        size: 15,
                      ),
                      Text.rich(TextSpan(
                          text: '4.8',
                          style: textTheme(context).bodyLarge!.copyWith(
                              color: colorScheme(context)
                                  .onPrimary
                                  .withOpacity(0.5)),
                          children: [
                            TextSpan(
                                text: '(review) 1k',
                                style: textTheme(context).bodyLarge!.copyWith(
                                    color: colorScheme(context).outline,
                                    letterSpacing: 0))
                          ]))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Vehicle Information',
                      style: textTheme(context).labelMedium!.copyWith(
                          color:
                              colorScheme(context).onPrimary.withOpacity(0.7),
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
                  Divider(
                    color: colorScheme(context).outline,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Current Location',
                      style: textTheme(context).labelMedium!.copyWith(
                          color:
                              colorScheme(context).onPrimary.withOpacity(0.7),
                          letterSpacing: 0)),
                  const SizedBox(
                    height: 12,
                  ),
                  //       ClipRRect(
                  //         borderRadius: BorderRadius.circular(18),
                  //         child: Container(
                  //           height: 264,
                  //           decoration: BoxDecoration(
                  //             color: Colors.red,
                  //             borderRadius: BorderRadius.circular(18),
                  //           ),
                  //           child: Consumer<MyGoogleMapController>(
                  //             builder: (context, mapController, child) {
                  //               return GoogleMap(
                  //                 initialCameraPosition: CameraPosition(
                  //                   target: mapController.initialPosition,
                  //                   zoom: 12,
                  //                 ),
                  //                 myLocationEnabled: true,
                  //                 onMapCreated: (GoogleMapController controller) {
                  //                   mapController.setController(controller);
                  //                 },
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 15,
                  //       ),
                  //       Text(
                  //         'About',
                  //         style: textTheme(context).titleMedium!.copyWith(
                  //             letterSpacing: 0, fontWeight: FontWeight.w700),
                  //       ),
                  //       Text(
                  //         '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.''',
                  //         style: textTheme(context).titleSmall!.copyWith(
                  //             letterSpacing: 0,
                  //             fontWeight: FontWeight.w400,
                  //             color: colorScheme(context).outline.withOpacity(0.5)),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Center(
                  //           child: Text(
                  //         'Sule Abdul',
                  //         style: textTheme(context).titleMedium!.copyWith(
                  //             letterSpacing: 0, fontWeight: FontWeight.w700),
                  //       )),
                  //       const SizedBox(
                  //         height: 8,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(
                  //             Icons.star,
                  //             color: colorScheme(context).primary,
                  //             size: 15,
                  //           ),
                  //           Text.rich(TextSpan(
                  //               text: '4.8',
                  //               style: textTheme(context).bodyLarge!.copyWith(
                  //                   color: colorScheme(context)
                  //                       .onPrimary
                  //                       .withOpacity(0.5)),
                  //               children: [
                  //                 TextSpan(
                  //                     text: '(review) 1k',
                  //                     style: textTheme(context).bodyLarge!.copyWith(
                  //                         color: colorScheme(context).outline,
                  //                         letterSpacing: 0))
                  //               ]))
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 15,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               context.pushNamed(AppRoute.customerChatPage);
                  //             },
                  //             child: Container(
                  //               padding: const EdgeInsets.all(10),
                  //               decoration: BoxDecoration(
                  //                   color: colorScheme(context).primary,
                  //                   borderRadius: const BorderRadius.only(
                  //                     topLeft: Radius.circular(4),
                  //                     topRight: Radius.circular(10),
                  //                     bottomRight: Radius.circular(4),
                  //                     bottomLeft: Radius.circular(10),
                  //                   )),
                  //               child: SvgPicture.asset(AppIcons.sms),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.all(10),
                  //             decoration: BoxDecoration(
                  //                 color: colorScheme(context).primary,
                  //                 borderRadius: const BorderRadius.only(
                  //                   topLeft: Radius.circular(4),
                  //                   topRight: Radius.circular(10),
                  //                   bottomRight: Radius.circular(4),
                  //                   bottomLeft: Radius.circular(10),
                  //                 )),
                  //             child: const Icon(
                  //               CupertinoIcons.phone,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         height: 15,
                  //       ),
                  //       Text('Vehicle Information',
                  //           style: textTheme(context).labelMedium!.copyWith(
                  //               color:
                  //                   colorScheme(context).onPrimary.withOpacity(0.7),
                  //               letterSpacing: 0)),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Toyota Prius-Black',
                  //             style: textTheme(context).labelMedium!.copyWith(
                  //                 letterSpacing: 0,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: colorScheme(context).outline),
                  //           ),
                  //           Text(
                  //             'License Plate: ABC 1234',
                  //             style: textTheme(context).labelMedium!.copyWith(
                  //                 letterSpacing: 0,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: colorScheme(context).onPrimary),
                  //           ),
                  //         ],
                  //       ),
                  //       Divider(
                  //         color: colorScheme(context).outline,
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text('current location',
                  //           style: textTheme(context).labelMedium!.copyWith(
                  //               color:
                  //                   colorScheme(context).onPrimary.withOpacity(0.7),
                  //               letterSpacing: 0)),
                  //       const SizedBox(
                  //         height: 12,
                  //       ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 264,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Consumer<MyGoogleMapController>(
                        builder: (context, googleController, child) {
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
                            onMapCreated: googleController.setController,
                            initialCameraPosition: CameraPosition(
                              target: googleController.currentLatLng ??
                                  googleController.initialPosition,
                              zoom: 14.0,
                            ),
                            markers: googleController.markers,
                            myLocationEnabled: false,
                            polylines: googleController.currentPolylines,
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: true,
                          );
                        },
                      ),

                      // Consumer<MyGoogleMapController>(
                      //   builder: (context, mapController, child) {
                      //     return GoogleMap(
                      //       initialCameraPosition: CameraPosition(
                      //         target: mapController.initialPosition,
                      //         zoom: 12,
                      //       ),
                      //       myLocationEnabled: true,
                      //       onMapCreated: (GoogleMapController controller) {
                      //         mapController.setController(controller);
                      //       },
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'About',
                    style: textTheme(context).titleMedium!.copyWith(
                        letterSpacing: 0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.''',
                    style: textTheme(context).titleSmall!.copyWith(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400,
                        color: colorScheme(context).outline.withOpacity(0.5)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
