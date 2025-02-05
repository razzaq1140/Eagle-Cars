import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/controllers/my_google_map_controller.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/customer_home_controller.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  final TextEditingController dropoffController = TextEditingController();
  List<bool> starSelected = [];
  @override
  void dispose() {
    dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer2<CustomerHomeController, MyGoogleMapController>(
          builder: (context, controller, map, widget) {
        return GestureDetector(
          onVerticalDragUpdate: controller.setBottomSheetHeight,
          child: Container(
            height: controller.bottomSheetHeight,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: colorScheme(context).surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
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
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: colorScheme(context).primary,
                                  width: 2.5),
                            ),
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme(context).primary,
                              ),
                            ),
                          ),
                          Dash(
                            direction: Axis.vertical,
                            length: 50,
                            dashLength: 6,
                            dashColor: colorScheme(context).outline,
                          ),
                          Icon(
                            Icons.location_on_rounded,
                            color: colorScheme(context).error,
                            size: 28,
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PICKUP',style: textTheme(context).bodyLarge?.copyWith(color: colorScheme(context).outline),),
                          Text(
                            map.currentLocation,
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: Divider(
                              height: 28,
                              color: colorScheme(context).outline,
                              thickness: 1,
                            ),
                          ),
                          Text('DROP-OFF',style: textTheme(context).bodyLarge?.copyWith(color: colorScheme(context).outline),),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                  AppRoute.customerDropOffLocationMapPage);
                            },
                            child: Text(
                              'Enter drop-off address',
                              style: textTheme(context)
                                  .bodyLarge
                                  ?.copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                controller.bottomSheetHeight <= 300
                    ? Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: Consumer<CustomerHomeController>(
                            builder: (context, controller, widget) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: controller.popularPlaces.map((place) {
                                return Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(place.place),
                                ));
                              }).toList(),
                            ),
                          );
                        }),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: MediaQuery.sizeOf(context).width,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              color:
                                  colorScheme(context).outline.withOpacity(0.6),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Popular Locations',
                                style: textTheme(context).titleSmall?.copyWith(
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.8),
                                    ),
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.popularPlaces.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Divider(
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.4)),
                                ),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.location_on_rounded,
                                      color: colorScheme(context).error,
                                      size: 28,
                                    ),
                                    title: Text(
                                        controller.popularPlaces[index].place),
                                    trailing: GestureDetector(
                                      onTap: () =>
                                          controller.changeStarred(index),
                                      child: Icon(
                                        controller
                                                .popularPlaces[index].isStarred
                                            ? Icons.star_rate_rounded
                                            : Icons.star_border_rounded,
                                        color: colorScheme(context).primary,
                                        size: 28,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
