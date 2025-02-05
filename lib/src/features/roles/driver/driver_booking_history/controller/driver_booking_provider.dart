import 'package:flutter/material.dart';

import '../models/booking_model.dart';

class DriverBookingProvider extends ChangeNotifier {
  String _activeTab = 'All';

  String get activeTab => _activeTab;

  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  final List<DriverBookingModel> bookings = [
    DriverBookingModel(
        date: DateTime(2024, 10, 21),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Completed', // Trimmed extra spaces here
        minsAgo: '2 mins ago'),
    DriverBookingModel(
        date: DateTime(2024, 10, 22),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Completed',
        minsAgo: '2 mins ago'),
    DriverBookingModel(
        date: DateTime(2024, 10, 23),
        pickUp: '123 Main St.',
        dropOff: '456 Business Rd.',
        price: 12.50,
        status: 'Ride Cancelled',
        minsAgo: '2 mins ago'),
  ];

  List<DriverBookingModel> getFilteredBookings() {
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
