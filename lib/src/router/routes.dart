import 'package:eagle_cars/src/features/roles/customer/driver_profile/pages/customer_driver_profile_page.dart';
import 'package:eagle_cars/src/features/roles/driver/accept/pages/driver_accepted_page.dart';
import 'package:eagle_cars/src/features/roles/role_screen.dart';
import '../features/roles/customer/booking_history/pages/booking_history_screen.dart';
import '../features/chat/pages/customer_chat_page.dart';
import '../features/roles/customer/customer_support/pages/customer_support_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:eagle_cars/src/features/auth/driver_auth/driver_update_password/pages/driver_update_password_screen.dart';

import '../features/auth/customer_auth/customer_forget_password/pages/forget_password_page.dart';
import '../features/auth/customer_auth/customer_login/pages/login_page.dart';
import '../features/auth/customer_auth/customer_sign_up/pages/signup_page.dart';
import '../features/auth/customer_auth/customer_successfully/pages/successfully_page.dart';
import '../features/auth/customer_auth/customer_update_password/pages/update_password_screen.dart';
import '../features/auth/customer_auth/customer_verification/pages/verification_page.dart';
import '../features/auth/driver_auth/driver_forget_password/pages/driver_forget_password_page.dart';
import '../features/auth/driver_auth/driver_login/pages/driver_login_page.dart';
import '../features/auth/driver_auth/driver_sign_up/pages/driver_signup_page.dart';
import '../features/auth/driver_auth/driver_successfully/pages/driver_successfully_page.dart';
import '../features/auth/driver_auth/driver_verification/pages/driver_verification_page.dart';
import '../features/onborading/pages/onboarding_page.dart';
import '../features/roles/customer/acount_detail/pages/customer_account_detail.dart';
import '../features/roles/customer/acount_detail/pages/customer_change_password_page.dart';
import '../features/roles/customer/customer_home/pages/customer_home_page.dart';
import '../features/roles/customer/customer_home/pages/location_denied_page.dart';
import '../features/roles/customer/customer_notification/pages/customer_notification_page.dart';
import '../features/roles/customer/customer_payment/pages/customer_payment_screen.dart';
import '../features/roles/customer/customer_profile/pages/customer_profile.dart';
import '../features/roles/customer/customer_ride_tracking/pages/customer_ride_tracking_page.dart';
import '../features/roles/customer/customer_search_location/page/customer_drop_location_map_page.dart';
import '../features/roles/customer/customer_setting/pages/customer_setting_page.dart';
import '../features/roles/driver/driver_account_detail/pages/driver_account_detail.dart';
import '../features/roles/driver/driver_account_detail/pages/driver_change_password_page.dart';
import '../features/roles/driver/driver_booking_history/pages/driver_booking_history_screen.dart';
import '../features/roles/driver/driver_customer_support/pages/driver_support_page.dart';
import '../features/roles/driver/driver_home/pages/driver_home_page.dart';
import '../features/roles/driver/driver_notification/pages/driver_notification_page.dart';
import '../features/roles/driver/driver_profile/pages/driver_profile_page.dart';
import '../features/roles/driver/driver_request/pages/driver_request_page.dart';
import '../features/roles/driver/driver_setting/pages/driver_setting_page.dart';
import '../features/roles/driver/driver_vehicle/pages/add_vehicle_page.dart';
import '../features/roles/driver/driver_vehicle/pages/vehicle_detail_page.dart';
import '../features/splash/pages/second_splash_page.dart';
import '../features/splash/pages/splash_page.dart';
import '../router/route_transition.dart';
import 'error_route.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.splashPage}',
    routes: [
      GoRoute(
        name: AppRoute.splashPage,
        path: '/${AppRoute.splashPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const SplashPage()),
      ),
      GoRoute(
        name: AppRoute.secondSplashPage,
        path: '/${AppRoute.secondSplashPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const SecondSplashPage()),
      ),
      GoRoute(
        name: AppRoute.onboardingPage,
        path: '/${AppRoute.onboardingPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const OnboardingScreen()),
      ),
      GoRoute(
        name: AppRoute.locationDeniedPage,
        path: '/${AppRoute.locationDeniedPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const LocationDeniedPage()),
      ),

      /// ############################################ [Customer Side] ############################################
      GoRoute(
        name: AppRoute.loginPage,
        path: '/${AppRoute.loginPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const LoginPage()),
      ),

      GoRoute(
        name: AppRoute.signUpPage,
        path: '/${AppRoute.signUpPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const SignUpPage()),
      ),
      GoRoute(
        name: AppRoute.verifyPage,
        path: '/${AppRoute.verifyPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const VerificationPage()),
      ),
      GoRoute(
        name: AppRoute.forgetPasswordPage,
        path: '/${AppRoute.forgetPasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const ForgetPasswordPage()),
      ),
      GoRoute(
        name: AppRoute.updatePasswordPage,
        path: '/${AppRoute.updatePasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const UpdatePasswordPage()),
      ),
      GoRoute(
        name: AppRoute.successfullyPage,
        path: '/${AppRoute.successfullyPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const SuccessfullyPage()),
      ),
      GoRoute(
        name: AppRoute.customerHomePage,
        path: '/${AppRoute.customerHomePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const CustomerHomePage()),
      ),

      GoRoute(
        name: AppRoute.customerNotificationPage,
        path: '/${AppRoute.customerNotificationPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: CustomerNotificationPage()),
      ),
      GoRoute(
        name: AppRoute.customerSettingPage,
        path: '/${AppRoute.customerSettingPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: CustomerSettingPage()),
      ),
      GoRoute(
        name: AppRoute.customerProfilePage,
        path: '/${AppRoute.customerProfilePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const CustomerProfilePage()),
      ),

      GoRoute(
        name: AppRoute.customerAccountDetailPage,
        path: '/${AppRoute.customerAccountDetailPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: const CustomerAccountDetailPage()),
      ),
      GoRoute(
        name: AppRoute.customerChangePasswordPage,
        path: '/${AppRoute.customerChangePasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const ChangePasswordPage()),
      ),
      GoRoute(
          name: AppRoute.customerDropOffLocationMapPage,
          path: '/${AppRoute.customerDropOffLocationMapPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const CustomerDropOffLocationMapPage())),
      GoRoute(
          name: AppRoute.customerPaymentPage,
          path: '/${AppRoute.customerPaymentPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const CustomerPaymentScreen())),
      GoRoute(
        name: AppRoute.customerChatPage,
        path: '/${AppRoute.customerChatPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const CustomerChatPage()),
      ),

      GoRoute(
        name: AppRoute.customerSupportPage,
        path: '/${AppRoute.customerSupportPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context, state: state, child: const CustomerSupportPage()),
      ),
      GoRoute(
          name: AppRoute.customerRideTrackingPage,
          path: '/${AppRoute.customerRideTrackingPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const CustomerRideTrackingPage())),

      GoRoute(
        name: AppRoute.customerDriverProfilePage,
        path: '/${AppRoute.customerDriverProfilePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: const CustomerDriverProfilePage()),
      ),
      GoRoute(
          name: AppRoute.customerBookingHistoryPage,
          path: '/${AppRoute.customerBookingHistoryPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const CustomerBookingHistoryScreen())),

      /// ############################################ [Driver Side] ############################################

      GoRoute(
          name: AppRoute.driverLoginPage,
          path: '/${AppRoute.driverLoginPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: const DriverLoginPage())),

      GoRoute(
          name: AppRoute.driverSignupPage,
          path: '/${AppRoute.driverSignupPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: const DriverSignupPage())),

      GoRoute(
          name: AppRoute.driverSuccessfullyPage,
          path: '/${AppRoute.driverSuccessfullyPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverSuccessfullyPage())),

      GoRoute(
          name: AppRoute.driverVerificationPage,
          path: '/${AppRoute.driverVerificationPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverVerificationPage())),

      GoRoute(
          name: AppRoute.driverForgetPasswordPage,
          path: '/${AppRoute.driverForgetPasswordPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverForgetPasswordPage())),

      GoRoute(
          name: AppRoute.driverUpdatePasswordPage,
          path: '/${AppRoute.driverUpdatePasswordPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverUpdatePasswordPage())),

      GoRoute(
          name: AppRoute.driverAddVehiclePage,
          path: '/${AppRoute.driverAddVehiclePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverAddVehiclePage())),

      GoRoute(
          name: AppRoute.driverHomePage,
          path: '/${AppRoute.driverHomePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: const DriverHomePage())),

      GoRoute(
          name: AppRoute.driverRequestPage,
          path: '/${AppRoute.driverRequestPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverRequestPage())),
      GoRoute(
          name: AppRoute.driverProfilePage,
          path: '/${AppRoute.driverProfilePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverProfilePage())),
      GoRoute(
          name: AppRoute.driverNotificationPage,
          path: '/${AppRoute.driverNotificationPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: DriverNotificationPage())),
      GoRoute(
          name: AppRoute.driverSettingPage,
          path: '/${AppRoute.driverSettingPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: DriverSettingPage())),
      GoRoute(
          name: AppRoute.driverAccountDetailPage,
          path: '/${AppRoute.driverAccountDetailPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverAccountDetailPage())),
      GoRoute(
          name: AppRoute.driverChangePasswordPage,
          path: '/${AppRoute.driverChangePasswordPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverChangePasswordPage())),
      GoRoute(
          name: AppRoute.driverBookingHistoryPage,
          path: '/${AppRoute.driverBookingHistoryPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverBookingHistoryScreen())),
      GoRoute(
          name: AppRoute.driverVehicleDetailPage,
          path: '/${AppRoute.driverVehicleDetailPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverVehicleDetailPage())),
      GoRoute(
          name: AppRoute.driverSupportPage,
          path: '/${AppRoute.driverSupportPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverSupportPage())),
      GoRoute(
          name: AppRoute.driverAcceptedPage,
          path: '/${AppRoute.driverAcceptedPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: const DriverAcceptedPage())),
      GoRoute(
          name: AppRoute.rolePage,
          path: '/${AppRoute.rolePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
              context: context, state: state, child: const RoleScreen())),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String splashPage = 'splash-page';
  static const String secondSplashPage = 'second-splash-page';
  static const String onboardingPage = 'onboarding-page';
  static const String locationDeniedPage = 'location-denied-page';
  static const String loginPage = 'login-page';
  static const String signUpPage = 'sign-up-page';
  static const String forgetPasswordPage = 'forget-password-page';
  static const String verifyPage = 'verify-page';
  static const String updatePasswordPage = 'customer-update-password-page';
  static const String successfullyPage = 'customer-customer_successfully-page';

  //////////////////[Driver Auth]///////////////////////////////////

  static const String driverForgetPasswordPage = 'driver-forget-password-page';
  static const String driverLoginPage = 'driver-login-page';
  static const String driverSignupPage = 'driver-sign-up-page';
  static const String driverSuccessfullyPage = 'driver-successfully-page';
  static const String driverUpdatePasswordPage = 'driver-update-password-page';
  static const String driverVerificationPage = 'driver-verification-page';

  /// ############################################ [Customer Side] ############################################

  static const String customerHomePage = 'customer-driver_home-page';
  static const String customerNotificationPage =
      'customer-driver_notification-page';
  static const String customerSettingPage = 'customer-driver_setting-page';
  static const String customerProfilePage = 'customer-driver_profile-page';
  static const String customerAccountDetailPage =
      'customer-account-detail-page';
  static const String customerChangePasswordPage =
      'customer-change-password-page';
  static const String customerChatPage = 'customer-chat-page';
  static const String customerPaymentPage = 'customer-customer_payment-page';
  static const String customerRideTrackingPage = 'customer-ride-tracking-page';
  static const String customerDriverProfilePage =
      'customer-driver-driver_profile-page';
  static const String customerSupportPage = 'customer-support-page';
  static const String customerDropOffLocationMapPage =
      'customer-drop-off-location-map-page';
  static const String customerBookingHistoryPage =
      'customer-booking-history-page';

  /// ############################################ [Driver Side] ############################################

  static const String driverHomePage = 'driver-driver_home-page';
  static const String driverNotificationPage =
      'driver-driver_notification-page';
  static const String driverSettingPage = 'driver-driver_setting-page';
  static const String driverProfilePage = 'driver-driver_profile-page';
  static const String driverAccountDetailPage = 'driver-account-detail-page';
  static const String driverChangePasswordPage = 'driver-change-password-page';
  static const String driverSupportPage = 'driver-support-page';
  static const String driverBookingHistoryPage = 'driver-booking-history-page';
  static const String driverAddVehiclePage = 'driver-add-vehicle-page';
  static const String driverVehicleDetailPage = 'driver-vehicle-detail-page';
  static const String driverRequestPage = 'driver-request-page';
  static const String driverAcceptedPage = 'driver-accepted-page';
  static const String rolePage = 'roles';
}
