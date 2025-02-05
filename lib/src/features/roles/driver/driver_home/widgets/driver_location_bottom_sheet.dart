import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverLocationBottomSheet extends StatefulWidget {
  const DriverLocationBottomSheet({super.key});

  @override
  State<DriverLocationBottomSheet> createState() => _DriverLocationBottomSheetState();
}

class _DriverLocationBottomSheetState extends State<DriverLocationBottomSheet> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isOnline = false;
  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      setState(() {
        isOnline = (result != ConnectivityResult.none);
      });
    });
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result){
      setState(() {
        isOnline = (result != ConnectivityResult.none);
      });
    });
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.23,
      child:Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorScheme(context).onSurface
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Center(
              child: Container(
                height: 6,
                width: 35,
                decoration: BoxDecoration(
                  color: colorScheme(context).outline,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8,),
            Center(child: Text(isOnline ? 'You are back Online' : 'You are currently offline',style: textTheme(context).titleMedium!.copyWith(fontWeight: FontWeight.w400,letterSpacing: 0,color: colorScheme(context).surface),)),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customColumWidget(icon: AppIcons.doneIcon, value: '95.0%', title: 'Acceptance'),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 105,
                  width: 1,
                  decoration: BoxDecoration(
                    color: colorScheme(context).outline,
                  ),
                ),
                customColumWidget(icon: AppIcons.ratingIcon, value: '4.75', title: 'Rating'),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 105,
                  width: 1,
                  decoration: BoxDecoration(
                    color: colorScheme(context).outline,
                  ),
                ),
                customColumWidget(icon: AppIcons.cancelIcon, value: '2.0%', title: 'Cancellation'),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget customColumWidget({required String icon, required String value, required String title}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SvgPicture.asset(icon,),
          const SizedBox(height: 5,),
          Text(value,style: textTheme(context).bodyLarge!.copyWith(letterSpacing: 0,color: colorScheme(context).surface),),
          const SizedBox(height: 2,),
          Text(title,style: textTheme(context).bodyLarge!.copyWith(letterSpacing: 0,color: colorScheme(context).surface),),
        ],
      ),
    );
  }
}
