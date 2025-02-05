import 'dart:developer' as dev;
import 'dart:math';
import 'package:eagle_cars/src/services/google_map_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/constants/app_images.dart';
import '../models/customer_driver_model.dart';
import '../models/customer_ride_model.dart';
import '../widgets/customer_select_driver_bottam_sheet.dart';

class DropLocationMapController extends ChangeNotifier {
  final GoogleMapApiService _googleMapApiService = GoogleMapApiService();

  bool? locationAllowed;
  CustomerRideModel? _selectedRide;
  List<String> _suggestions = [];
  bool _isTyping = false;
  List<bool> starSelected = [];

  bool get isTyping => _isTyping;
  List<String> get suggestions => _suggestions;
  CustomerRideModel? get selectedRide => _selectedRide;

  void selectRide(CustomerRideModel ride) {
    _selectedRide = ride;
    notifyListeners();
  }

  Future<void> searchPlace(String query) async {
    dev.log("Searching for places with query: $query");
    if (query.isEmpty) {
      dev.log("Query is empty, clearing suggestions.");
      _suggestions = [];
      starSelected = [];
      notifyListeners();
      return;
    }
    final response = await _googleMapApiService.searchPlace(query);
    dev.log("Received suggestions: $response");
    _suggestions = response;

    starSelected = List.generate(_suggestions.length, (index) => false);
    notifyListeners();
  }

  void toggleStarSelection(int index) {
    if (index >= 0 && index < starSelected.length) {
      starSelected[index] = !starSelected[index];
      notifyListeners();
    }
  }

  void startTyping() {
    dev.log("User started typing.");
    _isTyping = true;
    notifyListeners();
  }

  void stopTyping() {
    dev.log("User stopped typing.");
    _isTyping = false;
    _suggestions = [];
    notifyListeners();
  }

  List<CustomerRideModel> rides = [
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Just Go',
        icon: AppIcons.justGoCarIcon,
        distance: 'Near by You',
        price: '25.00',
        timeToReach: '2 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Limousine',
        icon: AppIcons.limousineCarIcon,
        distance: '0.2 km',
        price: '80.00',
        timeToReach: '5 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Luxury',
        icon: AppIcons.luxuryCarIcon,
        distance: '0.4 km',
        price: '50.00',
        timeToReach: '3 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'ElectricCar',
        icon: AppIcons.electricCarIcon,
        distance: '0.45 km',
        price: '25.00',
        timeToReach: '2 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Bike',
        icon: AppIcons.motorbikeIcon,
        distance: '0.48 km',
        price: '15.00',
        timeToReach: '3 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Taxi  4 seat',
        icon: AppIcons.taxiFourSeatCarIcon,
        distance: '0.5 km',
        price: '30.00',
        timeToReach: '4 min'),
    CustomerRideModel(
        id: Random().nextInt(126123).toString(),
        type: 'Taxi  7 seat',
        icon: AppIcons.taxiSevenSeatCarIcon,
        distance: '0.67 km',
        price: '40.00',
        timeToReach: '4 min'),
  ];

  int _dialogCount = 0; // Counter for open dialogs

  void showDrivers(
      CustomerDriverModel customerDriverModel, BuildContext context) {
    _dialogCount++; // Increment counter when showing a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectDriverDialog(
          customerDriverModel: customerDriverModel,
          onClose: () {
            _dialogCount--; // Decrement on close
            dev.log('count: $_dialogCount');
            notifyListeners();
            context.pop();
          },
          onConfirm: () => closeAllDialogs(context),
        );
      },
    );
  }

  void fetchAndShowDialogs(BuildContext context) {
    _dialogCount = 0;
    Random random = Random();
    for (int i = 0; i < random.nextInt(2) + 1; i++) {
      showDrivers(
        CustomerDriverModel(
          id: i.toString(),
          name: 'Gregory Smith $i',
          rating: '${Random().nextDouble() * 5.0}',
          recommendations: List.generate(
              Random().nextInt(8), (index) => NetworkImages.profileImage),
          ride: rides.firstWhere((ride) => ride.id == selectedRide?.id),
        ),
        context,
      );
    }
  }

  void closeAllDialogs(BuildContext context) {
    // Close all dialogs by popping the number of open dialogs
    for (int i = 0; i < _dialogCount; i++) {
      Navigator.of(context).pop(); // Close one dialog at a time
    }
    _dialogCount = 0; // Reset counter
    notifyListeners();
  }
}
