import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_request/widgets/custom_dialog.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_request/widgets/custom_row.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../../../common/controllers/driver_google_map_controller.dart';

// ignore: must_be_immutable
class AcceptCustomBottomSheet extends StatefulWidget {
  bool? showcallchat;
  VoidCallback onTap;
  double rating;
  Color color;

  AcceptCustomBottomSheet(
      {super.key,
      required this.rating,
      required this.showcallchat,
      required this.onTap,
      required this.color});

  @override
  State<AcceptCustomBottomSheet> createState() =>
      _AcceptCustomBottomSheetState();
}

class _AcceptCustomBottomSheetState extends State<AcceptCustomBottomSheet> {
  void _showDialogAndNavigate() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomDialog(),
    );
  }

  bool hasArrived = false;
  bool onTap = false;
  Timer? timer;
  late DriverGoogleMapController driverGoogleMapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driverGoogleMapController =
          Provider.of<DriverGoogleMapController>(context, listen: false);
      timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            hasArrived = true;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    if (!onTap) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        driverGoogleMapController.clearMarkersExceptCurrentLocation();
      });
    }
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.33,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: colorScheme(context).onSurface),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            NetworkImages.profileImage),
                      ),
                      Text(
                        'Alan Sanusi',
                        style: textTheme(context).bodySmall!.copyWith(
                            fontSize: 12,
                            letterSpacing: 0,
                            color: colorScheme(context).surface,
                            fontWeight: FontWeight.bold),
                      ),
                      SmoothStarRating(
                        allowHalfRating: true,
                        color: colorScheme(context).primary,
                        size: 20,
                        borderColor: Colors.white,
                        onRatingChanged: (v) {
                          widget.rating = v;
                        },
                        starCount: 5,
                        rating: widget.rating,
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
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '4.5km',
                            style: textTheme(context).titleMedium!.copyWith(
                                letterSpacing: 0,
                                color: colorScheme(context).surface,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomRow(
                          icon: const Icon(Icons.location_on),
                          color: colorScheme(context).surface,
                          title: '20 Kado street, Ikeja Lagos '),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                          icon: const Icon(Icons.location_on),
                          color: colorScheme(context).primary,
                          title: '20 Kado street, Ikeja Lagos '),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: widget.showcallchat == true
                        ? Row(
                            children: [
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: colorScheme(context)
                                    .primary
                                    .withOpacity(0.4),
                                child: Icon(
                                  Icons.phone,
                                  color: colorScheme(context).primary,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    context
                                        .pushNamed(AppRoute.customerChatPage);
                                  },
                                  child: Image.asset(AppImages.chatImage,
                                      height: 42)),
                              const SizedBox(width: 20),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        hasArrived
                            ? GestureDetector(
                                onTap: () {
                                  onTap = true;
                                  driverGoogleMapController
                                      .clearMarkersExceptCurrentLocation();
                                  _showDialogAndNavigate();
                                },
                                child: Container(
                                  height: 33,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: colorScheme(context).primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "Arrived pickup location",
                                    style: textTheme(context)
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                            : GestureDetector(
                                onTap: widget.onTap,
                                child: Container(
                                  height: 33,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: widget.color,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'Cancel',
                                    style: textTheme(context)
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            color: colorScheme(context).surface,
                                            fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
