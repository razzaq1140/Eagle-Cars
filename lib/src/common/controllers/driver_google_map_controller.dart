import 'dart:developer';

import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/text.dart';
import '../utils/custom_snackbar.dart';

class DriverGoogleMapController extends ChangeNotifier {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  LatLng? _searchLatLng;
  LatLng initialPosition = const LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {};
  Set<Polyline> currentPolylines = {};
  List<LatLng> polylineCoordinates = [];
  bool isLoading = false;
  Set<Circle> _circles = {};

  // Getters
  Set<Circle> get circles => _circles;
  GoogleMapController? get mapController => _mapController;
  LatLng? get currentLatLng => _currentLatLng;
  LatLng? get searchLatLng => _searchLatLng;
  Set<Marker> get markers => _markers;

  // Setters
  void setController(GoogleMapController controller) {
    _mapController = controller;
    getCurrentLocation();
  }

  void clearMarkersExceptCurrentLocation() async {
    _markers.clear();
    polylineCoordinates.clear();
    final customMarkerIcon = await createCustomMarkerDriverHome();
    _markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: _currentLatLng!,
      icon: customMarkerIcon,
      infoWindow: const InfoWindow(title: 'Your current location'),
    ));
    notifyListeners();
  }

  Future<BitmapDescriptor> createCustomMarkerDriverHome() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(17, 34)),
      AppImages.markerCarImage,
    );
  }

  Future<void> getCurrentLocation() async {
    print('getCurrentLocation called'); // Debug print

    if (isLoading) return;
    isLoading = true;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading = false;
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      isLoading = false;
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    _currentLatLng = LatLng(position.latitude, position.longitude);

    // Clear existing markers before adding new ones
    _markers.clear();

    final customMarkerIcon = await createCustomMarkerDriverHome();

    // Add the current location marker
    _markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: _currentLatLng!,
      icon: customMarkerIcon,
      infoWindow: const InfoWindow(title: 'Your current location'),
    ));

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentLatLng!, zoom: 15),
      ),
    );

    print('Marker added at: $_currentLatLng'); // Debug print

    isLoading = false;
    notifyListeners();
  }

  Future<void> setCurrentLocationMarker() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high),
        );
        _currentLatLng = LatLng(position.latitude, position.longitude);

        // Add a circle around the marker
        _circles = {
          Circle(
            circleId: const CircleId('radius'),
            center: _currentLatLng!,
            radius: 500,
            fillColor: Colors.yellow.withOpacity(0.1),
            strokeColor: Colors.yellow,
            strokeWidth: 0,
          ),
        };

        _mapController
            ?.animateCamera(CameraUpdate.newLatLngZoom(_currentLatLng!, 14.0));
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Error getting location: $e");
        }
      }
    } else {
      if (kDebugMode) {
        print("Location permission denied");
      }
    }
  }

  void getCustomerLocation() async {
    final position = _currentLatLng!;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.first;
    try {
      if (placemarks.isNotEmpty) {
        final location =
            await locationFromAddress(place.locality ?? place.country ?? '');
        if (location.isNotEmpty) {
          _searchLatLng =
              LatLng(location.first.latitude, location.first.longitude);
        } else {
          _searchLatLng = LatLng(
              _currentLatLng!.latitude + 1, _currentLatLng!.longitude + 2);
        }
        createPolyline(
            currentLocation:
                "${place.street}, ${place.locality},${place.country}",
            searchedLocation: place.locality ?? place.country ?? '');
      }
    } catch (e) {
      _searchLatLng =
          LatLng(_currentLatLng!.latitude + 1, _currentLatLng!.longitude + 2);
      createPolyline(
          currentLocation:
              "${place.street}, ${place.locality},${place.country}",
          searchedLocation: place.locality ?? place.country ?? '');
    }
    notifyListeners();
  }

  Future<void> createPolyline({
    required String currentLocation,
    required String searchedLocation,
  }) async {
    if (currentLocation.isEmpty || searchedLocation.isEmpty) {
      log('Cannot create polyline: Missing current or searched location');
      return;
    }

    try {
      log('Creating polyline between: $currentLocation and $searchedLocation');

      List<Location> currentLocations =
          await locationFromAddress(currentLocation);
      if (currentLocations.isNotEmpty) {
        _currentLatLng =
            LatLng(currentLocations[0].latitude, currentLocations[0].longitude);
      } else {
        log('No current locations found for: $currentLocation');
        return;
      }

      List<Location> searchedLocations =
          await locationFromAddress(searchedLocation);
      if (searchedLocations.isNotEmpty) {
        _searchLatLng = LatLng(
            searchedLocations[0].latitude, searchedLocations[0].longitude);
      } else {
        log('No searched locations found for: $searchedLocation');
        return;
      }

      _markers.clear();
      polylineCoordinates.clear();
      currentPolylines.clear();

      final result = await fetchRoute(_currentLatLng!, _searchLatLng!);

      if (result.points.isNotEmpty) {
        polylineCoordinates.addAll(result.points
            .map((point) => LatLng(point.latitude, point.longitude)));

        _addPolyLine();
        final customMarkerIcon = await createCustomMarkerDriverHome();

        // Add the current location marker
        _markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentLatLng!,
          icon: customMarkerIcon,
          infoWindow: const InfoWindow(title: 'Your current location'),
        ));

        _addMarker(
          _searchLatLng!,
          'endLocation',
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );

        await _adjustCameraToBounds(_currentLatLng!, _searchLatLng!);
      }
    } catch (e) {
      showSnackbar(
          message: 'Error creating path. Check your connection and try again',
          isError: true);
      log('Error creating polyline path: $e');
    }
  }

  Future<PolylineResult> fetchRoute(
      LatLng startLatLng, LatLng endLatLng) async {
    try {
      final polylineRequest = PolylineRequest(
        origin: PointLatLng(startLatLng.latitude, startLatLng.longitude),
        destination: PointLatLng(endLatLng.latitude, endLatLng.longitude),
        mode: TravelMode.driving,
      );

      final PolylineResult result =
          await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey: TextConstants.googleMapKey,
        request: polylineRequest,
      );

      return result;
    } catch (e) {
      showSnackbar(
          message: 'Failed to fetch route. No route found!', isError: true);
      throw Exception('Failed to fetch route');
    }
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    _markers.add(marker);
    notifyListeners();
  }

  Future<void> _adjustCameraToBounds(
      LatLng startLatLng, LatLng endLatLng) async {
    if (_mapController == null) return;

    LatLngBounds bounds;
    if (startLatLng.latitude > endLatLng.latitude &&
        startLatLng.longitude > endLatLng.longitude) {
      bounds = LatLngBounds(southwest: endLatLng, northeast: startLatLng);
    } else if (startLatLng.longitude > endLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(startLatLng.latitude, endLatLng.longitude),
          northeast: LatLng(endLatLng.latitude, startLatLng.longitude));
    } else if (startLatLng.latitude > endLatLng.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(endLatLng.latitude, startLatLng.longitude),
          northeast: LatLng(startLatLng.latitude, endLatLng.longitude));
    } else {
      bounds = LatLngBounds(southwest: startLatLng, northeast: endLatLng);
    }

    try {
      await _mapController
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    } catch (e) {
      log('Error adjusting camera bounds: $e');
    }
  }

  void _addPolyLine() {
    PolylineId id = const PolylineId("route");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.yellow,
      points: polylineCoordinates,
      width: 3,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    currentPolylines.add(polyline);
    notifyListeners();
  }
}
