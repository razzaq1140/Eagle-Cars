import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/text.dart';
import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';

class MyGoogleMapController extends ChangeNotifier {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  LatLng? _searchLatLng;
  LatLng initialPosition = const LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  String _currentLocation = '';
  String _searchLocation = '';
  BitmapDescriptor? _currentLocationMarker;
  BitmapDescriptor? _searchLocationMarker;
  Set<Polyline> currentPolylines = {};
  List<LatLng> polylineCoordinates = [];
  bool isLoading = false;
  Set<Marker> currentMarkers = {};

  // Getters
  GoogleMapController? get mapController => _mapController;
  LatLng? get currentLatLng => _currentLatLng;
  LatLng? get searchLatLng => _searchLatLng;
  Set<Marker> get markers => _markers;
  Set<Circle> get circles => _circles;
  String get currentLocation => _currentLocation;
  String get searchLocation => _searchLocation;

  // Setters
  void setController(GoogleMapController controller) {
    _mapController = controller;
    fetchCurrentLocation();
    notifyListeners();
  }

  void setCurrentLatlng() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    _currentLatLng = LatLng(position.latitude, position.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      _currentLocation = "${place.street}, ${place.locality},${place.country}";
      notifyListeners();
    }

    notifyListeners();
  }

  void clearMarkersExceptCurrentLocation() {
    _markers.clear();
    polylineCoordinates.clear();

    _markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: _currentLatLng!,
      icon: _currentLocationMarker!,
      infoWindow: const InfoWindow(title: 'Your current location'),
    ));
    notifyListeners();
  }

  void setSearchLatLng(LatLng searchLatLng) {
    _searchLatLng = searchLatLng;
    notifyListeners();
  }

  void setSearchLocation(String searchLocation) {
    _searchLocation = searchLocation;
    createPolyline(
        currentLocation: currentLocation, searchedLocation: searchLocation);
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadCustomMarkerIcon() async {
    _currentLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 50), devicePixelRatio: 2.5),
      AppImages.markImage,
    );
    _searchLocationMarker = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(50, 50), devicePixelRatio: 2.5),
      AppImages.endMarkImage,
    );
    // setCurrentLocationMarker();
    notifyListeners();
  }

  Future<void> setCurrentLocationMarker() async {
    var status = await Permission.location.request();

    if (status.isGranted ||
        status.isLimited ||
        status.isRestricted ||
        status.isProvisional) {
      try {
        log('marker');
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

  Future<BitmapDescriptor> createCustomerMarker() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(17, 34), devicePixelRatio: 2.5),
      AppImages.markImage,
    );
  }

  Future<void> moveToLocation(LatLng newLocation) async {
    if (mapController != null) {
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newLocation, zoom: 15.0),
        ),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    _currentLatLng = LatLng(position.latitude, position.longitude);
    final customMarkerIcon = await createCustomerMarker();
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

    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      _currentLocation = placemarks.isNotEmpty
          ? "${placemarks[0].street ?? ''}, ${placemarks[0].locality ?? ''}, ${placemarks[0].country ?? ''}"
          : "Unknown location";
      _currentLocationMarker = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(40, 50), devicePixelRatio: 2.5),
        AppImages.markImage,
      );
      _markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentLatLng!,
        icon: _currentLocationMarker!,
        infoWindow: const InfoWindow(title: 'Your current location'),
      ));
      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng!, zoom: 14.0),
        ),
      );

      notifyListeners();
    } catch (e) {
      log("Error fetching location: $e");
      _currentLocation = "Loading";
      notifyListeners();
    }
  }

  Future<void> createPolyline({
    required String currentLocation,
    required String searchedLocation,
  }) async {
    if (currentLocation.isEmpty || searchedLocation.isEmpty) {
      log('Cannot create polyline: Missing current or searched location');
      return;
    }

    setLoading(true);
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
        await loadCustomMarkerIcon();

        _addMarker(
          _currentLatLng!,
          'startLocation',
          _currentLocationMarker ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );

        _addMarker(
          _searchLatLng!,
          'endLocation',
          _searchLocationMarker ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );

        await _adjustCameraToBounds(_currentLatLng!, _searchLatLng!);
      }
    } catch (e) {
      showSnackbar(
          message: 'Error creating path. Check your connection and try again',
          isError: true);
      log('Error creating polyline path: $e');
    } finally {
      setLoading(false);
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
