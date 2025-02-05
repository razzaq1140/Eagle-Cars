import 'dart:math';

import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../models/customer_places_model.dart';

class CustomerHomeController extends ChangeNotifier {
  double _bottomSheetHeight = 260;
  final double _minHeight = 260;
  bool? locationAllowed;

  double get bottomSheetHeight => _bottomSheetHeight;

  void setBottomSheetHeight(DragUpdateDetails details) {
    _bottomSheetHeight -= details.delta.dy;
    if (_bottomSheetHeight < _minHeight) {
      _bottomSheetHeight = _minHeight;
    }
    notifyListeners();
  }

  void changeStarred(int index) {
    popularPlaces[index].isStarred = !popularPlaces[index].isStarred;
    notifyListeners();
  }

  List<CustomerPlacesModel> popularPlaces = [
    CustomerPlacesModel(
        place: 'University of Washington', isStarred: Random().nextBool()),
    CustomerPlacesModel(place: 'Woodland Park', isStarred: Random().nextBool()),
    CustomerPlacesModel(place: 'Husky Stadium', isStarred: Random().nextBool()),
    CustomerPlacesModel(place: 'Ravenna Park', isStarred: Random().nextBool()),
    CustomerPlacesModel(
        place: 'Henry Art Gallery', isStarred: Random().nextBool()),
    CustomerPlacesModel(
        place: 'Airport Center', isStarred: Random().nextBool()),
  ];

  Future<void> getPermission(BuildContext context, {bool? again}) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          locationAllowed = true;
          return;
        }
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.unableToDetermine) {
          showSnackbar(
              message: 'Location permission is denied!', isError: true);
          locationAllowed = null;
          context.pushReplacementNamed(AppRoute.locationDeniedPage);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        showSnackbar(message: 'Location is permanently denied!', isError: true);
        locationAllowed = false;
        context.pushReplacementNamed(AppRoute.locationDeniedPage);
      }
      if (again == true) {
        context.pushReplacementNamed(AppRoute.customerHomePage);
      }
    } catch (e) {
      rethrow;
    }
  }

  void goToHome(BuildContext context) =>
      context.pushReplacementNamed(AppRoute.customerHomePage);
}
