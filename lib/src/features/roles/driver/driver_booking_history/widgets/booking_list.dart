import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/features/roles/driver/driver_booking_history/controller/driver_booking_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../models/booking_model.dart';

class BookingListView extends StatelessWidget {
  final String bookingStatus;

  const BookingListView({super.key, required this.bookingStatus});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DriverBookingProvider>(context);
    final filteredBookings = provider.getFilteredBookings();

    final int rideCount = filteredBookings.length;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: rideCount,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final booking = filteredBookings[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                "Ride ${index + 1} Summary",
                style: textTheme(context)
                    .headlineLarge
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            _buildBookingCard(context, booking),
          ],
        );
      },
    );
  }

  Widget _buildBookingCard(BuildContext context, DriverBookingModel booking) {
    return SizedBox(
      height: 180,
      child: Card(
        color: colorScheme(context).surface,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 100,
                  height: 140,
                  child: Image.network(NetworkImages.mapImg, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.calendar,
                              size: 10,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.6)),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '${formatDate(booking.date)} ',
                            style: textTheme(context).headlineMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.6),
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(CupertinoIcons.time,
                              size: 10,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.6)),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            booking.minsAgo,
                            style: textTheme(context).bodyMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.6),
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 10,
                            color:
                            colorScheme(context).onSurface.withOpacity(0.4),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            booking.status,
                            style: textTheme(context).headlineMedium?.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w300,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.6)),
                          ),
                        ],
                      ),
                      const Spacer()
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp,
                          color: colorScheme(context).primary),
                      Text(
                        'Pickup:',
                        style: textTheme(context).headlineMedium?.copyWith(
                            color:
                            colorScheme(context).onSurface.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      const Spacer(),
                      Text(
                        booking.pickUp,
                        style: textTheme(context).headlineMedium?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: colorScheme(context).primary,
                      ),
                      Text('Drop-Off:',
                          style: textTheme(context).headlineMedium?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.4),
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                      const Spacer(),
                      Text(
                        booking.dropOff,
                        style: textTheme(context).headlineMedium?.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\$${booking.price.toStringAsFixed(2)}',
                        style: textTheme(context).headlineLarge?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        width: 125,
                        child: CustomElevatedButton(
                            textSize: 12,
                            onPressed: () {},
                            text: 'View Details'),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }



  // @override
  // Widget build(BuildContext context) {
  //   final provider = Provider.of<DriverBookingProvider>(context);
  //   final filteredBookings = provider.getFilteredBookings();
  //
  //   final int rideCount = filteredBookings.length;
  //
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     itemCount: rideCount,
  //     physics: const ClampingScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       final bookingModel = filteredBookings[index];
  //
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  //             child: Text(
  //               "Ride ${index + 1} Summary",
  //               style: textTheme(context)
  //                   .headlineLarge
  //                   ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //           _buildBookingCard(context, bookingModel),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildBookingCard(BuildContext context, DriverBookingModel booking) {
  //   return SizedBox(
  //     height: 180,
  //     child: Card(
  //       color: colorScheme(context).surface,
  //       child: Row(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(15),
  //               child: SizedBox(
  //                 width: 100,
  //                 height: 140,
  //                 child: Image.network(NetworkImages.mapImg, fit: BoxFit.cover),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 const Spacer(),
  //                 Row(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Icon(CupertinoIcons.calendar,
  //                             size: 10,
  //                             color: colorScheme(context)
  //                                 .onSurface
  //                                 .withOpacity(0.6)),
  //
  //                         Text(
  //                           '${formatDate(booking.date)} ',
  //                           style: textTheme(context).headlineMedium?.copyWith(
  //                               color: colorScheme(context)
  //                                   .onSurface
  //                                   .withOpacity(0.6),
  //                               fontSize: 9,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                       ],
  //                     ),
  //                     const Spacer(),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           CupertinoIcons.time,
  //                           size: 10,
  //                           color:
  //                               colorScheme(context).onSurface.withOpacity(0.6),
  //                         ),
  //
  //                         Text(
  //                           booking.minsAgo,
  //                           style: textTheme(context).bodyMedium?.copyWith(
  //                               color: colorScheme(context)
  //                                   .onSurface
  //                                   .withOpacity(0.6),
  //                               fontSize: 9,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                       ],
  //                     ),
  //                     const Spacer(),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.check_circle_outline,
  //                           size: 9,
  //                           color:
  //                               colorScheme(context).onSurface.withOpacity(0.4),
  //                         ),
  //
  //                         SizedBox(
  //                           width: 50,
  //                           child: Text(booking.status,
  //                               style: textTheme(context)
  //                                   .headlineMedium
  //                                   ?.copyWith(
  //                                       fontSize: 9,
  //                                       fontWeight: FontWeight.w300,
  //                                       color: colorScheme(context)
  //                                           .onSurface
  //                                           .withOpacity(0.6))),
  //                         ),
  //                       ],
  //                     ),
  //                     const Spacer()
  //                   ],
  //                 ),
  //                 const Spacer(),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.location_on_sharp,
  //                         color: colorScheme(context).primary),
  //                     Text(
  //                       'Pickup:',
  //                       style: textTheme(context).headlineMedium?.copyWith(
  //                           color:
  //                               colorScheme(context).onSurface.withOpacity(0.6),
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w300),
  //                     ),
  //                     const Spacer(),
  //                     Text(
  //                       booking.pickUp,
  //                       style: textTheme(context).headlineMedium?.copyWith(
  //                           fontSize: 14, fontWeight: FontWeight.w400),
  //                     ),
  //                     const SizedBox(
  //                       width: 20,
  //                     )
  //                   ],
  //                 ),
  //                 const Spacer(),
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.pin_drop,
  //                       color: colorScheme(context).primary,
  //                     ),
  //                     Text('Drop-Off:',
  //                         style: textTheme(context).headlineMedium?.copyWith(
  //                             color: colorScheme(context)
  //                                 .onSurface
  //                                 .withOpacity(0.6),
  //                             fontSize: 13,
  //                             fontWeight: FontWeight.w300)),
  //                     const Spacer(),
  //                     Text(
  //                       booking.dropOff,
  //                       style: textTheme(context).headlineMedium?.copyWith(
  //                           fontSize: 13, fontWeight: FontWeight.w400),
  //                     ),
  //                     const SizedBox(
  //                       width: 9,
  //                     )
  //                   ],
  //                 ),
  //                 const Spacer(),
  //                 Row(
  //                   children: [
  //                     const SizedBox(
  //                       width: 9,
  //                     ),
  //                     Text(
  //                       '\$${booking.price.toStringAsFixed(2)}',
  //                       style: textTheme(context).headlineLarge?.copyWith(
  //                           fontSize: 14, fontWeight: FontWeight.w600),
  //                     ),
  //                     const Spacer(),
  //                     SizedBox(
  //                       height: 40,
  //                       width: 125,
  //                       child: CustomElevatedButton(
  //                           textSize: 12,
  //                           onPressed: () {},
  //                           text: 'View Details'),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     )
  //                   ],
  //                 ),
  //                 const Spacer()
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // String formatDate(DateTime date) {
  //   return "${date.month}/${date.day}/${date.year}";
  // }
}
