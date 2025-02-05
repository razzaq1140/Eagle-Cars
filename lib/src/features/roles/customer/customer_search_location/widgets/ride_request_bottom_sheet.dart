import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';
import '../../../../../router/routes.dart';
import '../controller/drop_location_map_controller.dart';
import 'promo_code_bottom_sheet.dart';
import 'select_ride_bottom_sheet.dart';

class RideRequestBottomSheet extends StatefulWidget {
  const RideRequestBottomSheet({super.key});

  @override
  State<RideRequestBottomSheet> createState() => _RideRequestBottomSheetState();
}

class _RideRequestBottomSheetState extends State<RideRequestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final dropLocationMapController =
        Provider.of<DropLocationMapController>(context, listen: false);
    return Container(
      height: 250,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: colorScheme(context).surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<DropLocationMapController>(
              builder: (context, controller, widget) {
            final ride = controller.selectedRide ?? controller.rides[0];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SelectRideBottomSheet();
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: colorScheme(context).outline.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colorScheme(context).outline,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ride.icon),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ride.type,
                              style: textTheme(context)
                                  .bodyLarge
                                  ?.copyWith(fontSize: 16),
                            ),
                            Text(
                              ride.distance,
                              style: textTheme(context).bodyLarge?.copyWith(
                                  color: colorScheme(context).outline),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${ride.price}',
                              style: textTheme(context).bodyLarge?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              ride.timeToReach,
                              style: textTheme(context).bodyLarge?.copyWith(
                                  color: colorScheme(context).outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bottomSheetImageButton(
                  onTap: () => context.pushNamed(AppRoute.customerPaymentPage),
                  icon: AppIcons.walletIcon,
                  title: 'Payment',
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 2,
                    color: colorScheme(context).outline.withOpacity(0.4),
                  ),
                ),
                _bottomSheetImageButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const PromoCodeBottomSheet();
                      },
                    );
                  },
                  icon: AppIcons.couponIcon,
                  title: 'Promo Code',
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 2,
                    color: colorScheme(context).outline.withOpacity(0.4),
                  ),
                ),
                _bottomSheetImageButton(
                  onTap: () {},
                  icon: AppIcons.otherOptionIcon,
                  title: 'Other',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CustomElevatedButton(
                onPressed: () {
                  // context.pop();
                  dropLocationMapController.fetchAndShowDialogs(context);
                },
                text: 'Request'),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetImageButton(
      {required void Function() onTap,
      required String icon,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            Text(
              title,
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(color: colorScheme(context).outline),
            ),
          ],
        ),
      ),
    );
  }
}
