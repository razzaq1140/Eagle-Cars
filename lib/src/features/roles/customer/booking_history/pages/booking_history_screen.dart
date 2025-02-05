import 'package:eagle_cars/src/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/global_variable.dart';
import '../../../../../theme/color_scheme.dart';
import '../../../driver/driver_booking_history/widgets/my_custom_field.dart';
import '../models/booking_model.dart';
import '../widgets/booking_list.dart';

class BookingProvider extends ChangeNotifier {
  String _activeTab = 'All';

  String get activeTab => _activeTab;

  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  final List<BookingModel> bookings = [
    BookingModel(
        date: DateTime(2024, 10, 21),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Completed', // Trimmed extra spaces here
        minsAgo: '2 mins ago'),
    BookingModel(
        date: DateTime(2024, 10, 22),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Completed',
        minsAgo: '2 mins ago'),
    BookingModel(
        date: DateTime(2024, 10, 23),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Cancelled',
        minsAgo: '2 mins ago'),
  ];

  List<BookingModel> getFilteredBookings() {
    if (_activeTab == 'All') return bookings;

    return bookings.where((booking) {
      // Direct comparison to match the exact booking status
      if (_activeTab == 'Ride Completed') {
        return booking.status == 'Ride Completed';
      } else if (_activeTab == 'Ride Cancelled') {
        return booking.status == 'Ride Completed';
      }
      return false; // Should not reach here
    }).toList();
  }
}

class CustomerBookingHistoryScreen extends StatefulWidget {
  const CustomerBookingHistoryScreen({super.key});

  @override
  _CustomerBookingHistoryScreenState createState() =>
      _CustomerBookingHistoryScreenState();
}

class _CustomerBookingHistoryScreenState
    extends State<CustomerBookingHistoryScreen> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    final tabs = ['All', 'Ride Completed', 'Ride Cancelled'];
    Provider.of<BookingProvider>(context, listen: false)
        .setActiveTab(tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
