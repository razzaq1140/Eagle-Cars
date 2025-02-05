import 'dart:async';
import 'package:eagle_cars/src/common/controllers/driver_google_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverAcceptedProvider extends ChangeNotifier {
  double rating = 1.0;
  String buttonText = 'Cancel';
  bool isValue = false;
  bool isFinalButtonVisible = false;
  bool isTripStarted = false;
  bool showCustomMarker = false;
  BitmapDescriptor? customMarker;
  LatLng currentLocation = const LatLng(29.395624, 71.683472);

  void updateCurrentLocation({required LatLng location}) {
    currentLocation = location;
    notifyListeners();
  }

  void setRating(double newRating) {
    rating = newRating;
    notifyListeners();
  }

  void setButtonTextAndLocation() {
    buttonText = 'Arrived pickup location';
    isValue = true;
    showCustomMarker = true;

    // Specific location jahan map aur marker move hoga button click ke baad
    LatLng arrivedLocation = const LatLng(29.385585, 71.710458);

    // Current location ko update karna specific location par
    updateCurrentLocation(location: arrivedLocation);

    // Map ko specific location par animate karna
    DriverGoogleMapController().mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: arrivedLocation, zoom: 30),
      ),
    );

    notifyListeners();
  }

  void loadCustomMarker(BitmapDescriptor marker) {
    customMarker = marker;
    notifyListeners();
  }

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 15));
    LatLng specificLocation = const LatLng(29.399575, 71.716088);
    updateCurrentLocation(location: specificLocation);

    DriverGoogleMapController().mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: specificLocation, zoom: 30),
      ),
    );

    setButtonTextAndLocation();
    notifyListeners();
  }

  void toggleFinalButtonVisibility() {
    if (!isFinalButtonVisible) {
      isFinalButtonVisible = true;
    } else {
      isTripStarted = true;
      isFinalButtonVisible = false;
      LatLng tripStartLocation = const LatLng(29.401234, 71.712345); // New location for trip start
      updateCurrentLocation(location: tripStartLocation);

      DriverGoogleMapController().mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: tripStartLocation, zoom: 30),
        ),
      );
    }
    notifyListeners();
  }
}
