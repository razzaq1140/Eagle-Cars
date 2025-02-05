import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../common/constants/global_variable.dart';
import '../controller/drop_location_map_controller.dart';

class SelectRideBottomSheet extends StatefulWidget {
  const SelectRideBottomSheet({super.key});

  @override
  State<SelectRideBottomSheet> createState() => _SelectRideBottomSheetState();
}

class _SelectRideBottomSheetState extends State<SelectRideBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DropLocationMapController>(
        builder: (context, controller, widget) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.6,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: Container(
                width: 80,
                height: 7,
                decoration: BoxDecoration(
                  color: colorScheme(context).outline,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: controller.rides.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: colorScheme(context).outline.withOpacity(0.4),
                  ),
                ),
                itemBuilder: (context, index) {
                  final ride = controller.rides[index];
                  final isSelected = ride.id == controller.selectedRide?.id;
                  return GestureDetector(
                    onTap: () => controller.selectRide(ride),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      color: isSelected
                          ? colorScheme(context).primary
                          : colorScheme(context).surface,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ride.icon,
                            colorFilter: ColorFilter.mode(
                                isSelected
                                    ? colorScheme(context).onPrimary
                                    : colorScheme(context).outline,
                                BlendMode.srcIn),
                          ),
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
