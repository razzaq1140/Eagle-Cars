import 'package:eagle_cars/src/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/global_variable.dart';
import '../../../../../theme/color_scheme.dart';
import '../../../customer/booking_history/widgets/my_custom_field.dart';
import '../controller/driver_booking_provider.dart';
import '../widgets/booking_list.dart';

class DriverBookingHistoryScreen extends StatefulWidget {
  const DriverBookingHistoryScreen({super.key});

  @override
  State<DriverBookingHistoryScreen> createState() =>
      _DriverBookingHistoryScreenState();
}

class _DriverBookingHistoryScreenState
    extends State<DriverBookingHistoryScreen> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    final tabs = ['All', 'Ride Completed', 'Ride Cancelled'];
    Provider.of<DriverBookingProvider>(context, listen: false)
        .setActiveTab(tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DriverBookingProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme(context).surface,
      appBar: AppBar(
        backgroundColor: colorScheme(context).surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme(context).onPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking History',
              style: textTheme(context).headlineMedium?.copyWith(
                  fontSize: 24,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            const MyCustomField(),
            const SizedBox(
              height: 5,
            ),
            TabBarWithSliding(
              activeTab: provider.activeTab,
              onTabSelected: (tab) {
                provider.setActiveTab(tab);
                int index =
                    ['All', 'Ride Completed', 'Ride Cancelled'].indexOf(tab);
                _pageController.jumpToPage(index);
              },
              pageController: _pageController,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  BookingListView(bookingStatus: 'All'),
                  BookingListView(bookingStatus: 'Ride Completed'),
                  BookingListView(bookingStatus: 'Cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarWithSliding extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabSelected;
  final PageController pageController;

  const TabBarWithSliding({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    // Define the text style using the context's theme

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['All', 'Ride Completed', 'Ride Cancelled'].map((tab) {
          final isActive = activeTab == tab;
          return GestureDetector(
            onTap: () {
              onTabSelected(tab);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme(context).primary
                    : TransparentColor.transparentColor,
                borderRadius: BorderRadius.circular(10),
                border: isActive
                    ? Border.all(color: colorSchemeLight.primary)
                    : null,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(tab,
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: colorSchemeLight.onPrimary)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
