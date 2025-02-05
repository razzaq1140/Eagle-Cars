import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../models/customer_driver_model.dart';

class SelectDriverDialog extends StatelessWidget {
  final CustomerDriverModel customerDriverModel;
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const SelectDriverDialog(
      {super.key,
      required this.customerDriverModel,
      required this.onClose,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), // Unique key for the dismissible
      direction: DismissDirection.horizontal, // Allow vertical swipes
      onDismissed: (direction) => onClose(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Dialog(
        child: SelectDriverDialogBody(
          customerDriverModel: customerDriverModel,
          onConfirm: onConfirm,
        ),
      ),
    );
  }
}

class SelectDriverDialogBody extends StatefulWidget {
  final CustomerDriverModel customerDriverModel;
  final void Function() onConfirm;
  const SelectDriverDialogBody(
      {super.key, required this.customerDriverModel, required this.onConfirm});

  @override
  State<SelectDriverDialogBody> createState() => _SelectDriverDialogBodyState();
}

class _SelectDriverDialogBodyState extends State<SelectDriverDialogBody> {
  @override
  Widget build(BuildContext context) {
    CustomerDriverModel customerDriverModel = widget.customerDriverModel;
    return Container(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: colorScheme(context).surface,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: colorScheme(context).outline.withOpacity(0.1)),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage:
                      CachedNetworkImageProvider(NetworkImages.profileImage),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerDriverModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme(context)
                            .titleMedium!
                            .copyWith(fontSize: 17, letterSpacing: 0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star_rate_rounded,
                              color: colorScheme(context).primary),
                          Text(
                            customerDriverModel.rating.substring(0, 3),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).titleMedium!.copyWith(
                                fontSize: 15,
                                color: colorScheme(context).outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => context.pushNamed(AppRoute.customerChatPage),
                  child: CircleAvatar(
                    backgroundColor: colorScheme(context).secondary,
                    child: SvgPicture.asset(
                      AppIcons.messageIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const CircleAvatar(
                  child: Icon(Icons.phone),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Row(
              children: [
                ...List.generate(
                    customerDriverModel.recommendations.length < 4
                        ? customerDriverModel.recommendations.length
                        : 3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                          customerDriverModel.recommendations[index]),
                    ),
                  );
                }),
                Flexible(
                  child: Text(
                    '${customerDriverModel.recommendations.length} Recommendations',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme(context)
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: colorScheme(context).outline,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(customerDriverModel.ride.icon),
                    const SizedBox(width: 8),
                    customColum(
                      title: 'Distance',
                      distance: customerDriverModel.ride.distance,
                    ),
                    customColum(
                      title: 'Time',
                      distance: customerDriverModel.ride.timeToReach,
                    ),
                    customColum(
                      title: 'Price',
                      distance: '\$${customerDriverModel.ride.price}',
                    ),
                  ],
                ),
              ],
            ),
          )
          //   ;
          // })
          ,
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomElevatedButton(
                onPressed: () {
                  widget.onConfirm();
                  showMyDialog();
                },
                text: 'Confirm'),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget customColum({required String title, required String distance}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme(context).bodyLarge!.copyWith(
              color: colorScheme(context).outline, fontWeight: FontWeight.bold),
        ),
        Text(
          distance,
          style: textTheme(context).bodyLarge!.copyWith(
              color: colorScheme(context).onSurface,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future showMyDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.only(top: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.alertCircleIcon),
              const SizedBox(height: 10),
              Text(
                "Booking Successful",
                style: textTheme(context)
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "Your booking has been confirmed.\nDriver will pickup you in 2 minutes.",
                textAlign: TextAlign.center,
                style: textTheme(context)
                    .bodyLarge!
                    .copyWith(color: colorScheme(context).outline),
              ),
              const SizedBox(height: 20),
              Divider(
                height: 1,
                color: colorScheme(context).outline,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: textTheme(context).bodyLarge!.copyWith(
                            color: colorScheme(context).outline,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: colorScheme(context).outline,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.pop();
                        context.pushNamed(AppRoute.customerRideTrackingPage);
                      },
                      child: Text(
                        "Track",
                        style: textTheme(context).bodyLarge!.copyWith(
                            color: colorScheme(context).primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
