import 'dart:developer';

import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/controllers/my_google_map_controller.dart';
import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../controller/drop_location_map_controller.dart';
import '../widgets/ride_request_bottom_sheet.dart';

class CustomerDropOffLocationMapPage extends StatefulWidget {
  const CustomerDropOffLocationMapPage({super.key});

  @override
  State<CustomerDropOffLocationMapPage> createState() =>
      _CustomerDropOffLocationMapPageState();
}

class _CustomerDropOffLocationMapPageState
    extends State<CustomerDropOffLocationMapPage> {
  final TextEditingController dropoffController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<bool> starSelected = [];
  late MyGoogleMapController myGoogleMapController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myGoogleMapController =
          Provider.of<MyGoogleMapController>(context, listen: false);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myGoogleMapController.clearMarkersExceptCurrentLocation();
    });
    dropoffController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dropLocationMapController =
        Provider.of<DropLocationMapController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer2<DropLocationMapController, MyGoogleMapController>(
          builder: (context, controller, locationProvider, widget) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: locationProvider.setController,
                  initialCameraPosition: CameraPosition(
                    target: locationProvider.currentLatLng ??
                        locationProvider.initialPosition,
                    zoom: 14.0,
                  ),
                  markers: locationProvider.markers,
                  myLocationEnabled: false,
                  polylines: locationProvider.currentPolylines,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: controller.isTyping
                          ? MediaQuery.of(context).size.height * 0.5
                          : MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            title: TextField(
                              focusNode: _focusNode,
                              controller: dropoffController,
                              onChanged: (value) {
                                controller.startTyping();
                                controller.searchPlace(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Drop-off address',
                                hintStyle: textTheme(context)
                                    .bodyLarge
                                    ?.copyWith(fontSize: 20),
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    dropoffController.clear();
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (controller.isTyping)
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.suggestions.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        title: Text(
                                          controller.suggestions[index],
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(fontSize: 16),
                                        ),
                                        onTap: () {
                                          dropoffController.text =
                                              controller.suggestions[index];
                                          controller.stopTyping();
                                          FocusScope.of(context).unfocus();
                                          locationProvider.setSearchLocation(
                                              dropoffController.text);
                                        },
                                        trailing: GestureDetector(
                                          onTap: () {
                                            controller
                                                .toggleStarSelection(index);
                                          },
                                          child: Icon(
                                            controller.starSelected[index]
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: controller
                                                    .starSelected[index]
                                                ? colorScheme(context).primary
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 100,
                  child: GestureDetector(
                    onTap: () {
                      locationProvider.getCurrentLocation();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: colorScheme(context).surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomElevatedButton(
                        height: 50,
                        width: double.infinity,
                        onPressed: () {
                          if (locationProvider.searchLocation.isNotEmpty) {
                            dropLocationMapController.selectRide(
                                dropLocationMapController.rides.first);
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const RideRequestBottomSheet();
                              },
                            );
                          } else {
                            log('message');
                            showSnackbar(
                                message: 'Please select a drop-off address',
                                isError: true);
                          }
                        },
                        text: 'Apply'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
