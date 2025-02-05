import 'package:device_preview/device_preview.dart';
import 'package:eagle_cars/src/common/controllers/driver_google_map_controller.dart';
import 'package:eagle_cars/src/features/onborading/provider/onboarding_provider.dart';
import 'package:eagle_cars/src/features/roles/driver/accept/provider/driver_accepted_provider.dart';
import 'package:eagle_cars/src/features/roles/customer/booking_history/pages/booking_history_screen.dart';
import 'package:eagle_cars/src/features/roles/customer/customer_home/controller/customer_home_controller.dart';
import 'package:eagle_cars/src/features/roles/customer/customer_payment/provider/customer_container_provider.dart';
import 'package:eagle_cars/src/features/roles/customer/customer_search_location/controller/drop_location_map_controller.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:eagle_cars/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'src/common/constants/global_variable.dart';
import 'src/common/controllers/my_google_map_controller.dart';
import 'src/features/roles/driver/driver_booking_history/controller/driver_booking_provider.dart';
import 'src/features/roles/driver/driver_home/controller/driver_home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageIndexProvider()),
        ChangeNotifierProvider(create: (_) => MyGoogleMapController()),
        ChangeNotifierProvider(create: (_) => CustomerHomeController()),
        ChangeNotifierProvider(create: (_) => DropLocationMapController()),
        ChangeNotifierProvider(create: (_) => CustomerContainerProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => DriverHomeController()),
        ChangeNotifierProvider(create: (_) => DriverBookingProvider()),
        ChangeNotifierProvider(create: (_) => DriverAcceptedProvider()),
        ChangeNotifierProvider(create: (_) => DriverGoogleMapController()),
      ],
      child:
          // DevicePreview(
          // enabled: !kReleaseMode,
          // builder: (context) =>
          const MyApp(), // Wrap your app
      // ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: AppTheme.instance.lightTheme,
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
      ),
    );
  }
}
