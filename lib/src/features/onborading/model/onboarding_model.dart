import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/features/onborading/widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class OnBoardingModel {
  CustomClipper<Path> clipper;
  String image;
  String title;
  String subTitle;

  OnBoardingModel(
      {required this.clipper,
      required this.image,
      required this.title,
      required this.subTitle});
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
      clipper: WaveClipperTwo(),
      image: AppImages.onboardingImages1,
      title: 'Welcome to Eagles Cars',
      subTitle: 'Your trusted ride, anytime and anywhere in Africa.'),
  OnBoardingModel(
      clipper: OvalBottomBorderClipper(),
      image: AppImages.onboardingImages2,
      title: 'Easy Ride Booking',
      subTitle: 'Book rides easily with just a few taps.'),
  OnBoardingModel(
      clipper: MyCustomClipper(),
      image: AppImages.onboardingImages3,
      title: 'Real Time Tracking',
      subTitle: 'Track your ride in real-time and stay informed.'),
  OnBoardingModel(
      clipper: WaveClipperOne(),
      image: AppImages.onboardingImages4,
      title: 'Hi, Nice to Meet You!',
      subTitle: 'Choose your location to start find restaurants around you.'),
];




// class MyCustomClipper2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height); // Curve ko neeche laya gya
//     path.quadraticBezierTo(
//       size.width / 2, size.height, // Bezier curve ke points adjust kiye gaye hain
//       size.width, size.height - 140,
//     );
//     path.lineTo(size.width, 0); // Top right corner tak line kheenchna
//     path.close(); // Path ko close karna
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false; // Path ko har dafa recalculate nahi karna
//   }
// }


