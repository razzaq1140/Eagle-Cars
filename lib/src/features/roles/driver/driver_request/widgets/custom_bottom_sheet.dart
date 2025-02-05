import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_request/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class CustomBottomSheet extends StatefulWidget {
  final double? rating;
  final VoidCallback ontap;
  const CustomBottomSheet(
      {super.key, required this.rating, required this.ontap});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int countDown = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCount();
    });
  }

  void _startCount() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown > 0) {
        if (mounted) {
          setState(() {
            countDown--;
          });
        }
      } else {
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
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
                          widget.rating != v;
                          setState(() {});
                        },
                        starCount: 5,
                        rating: widget.rating!,
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
                          icon: const Icon(
                            Icons.location_on,
                          ),
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 33,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: colorScheme(context).error,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Reject',
                        style: textTheme(context).bodySmall!.copyWith(
                            fontSize: 12,
                            letterSpacing: 0,
                            color: colorScheme(context).surface,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: colorScheme(context).surface,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          countDown.toString(),
                          style: textTheme(context)
                              .labelSmall!
                              .copyWith(color: colorScheme(context).primary),
                        ),
                        CircularProgressIndicator(
                          value: countDown / 30,
                          color: colorScheme(context).primary,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.ontap,
                    child: Container(
                      height: 33,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: colorScheme(context).primary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Accept',
                        style: textTheme(context).bodySmall!.copyWith(
                            fontSize: 12,
                            letterSpacing: 0,
                            color: colorScheme(context).surface,
                            fontWeight: FontWeight.bold),
                      )),
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
