import 'dart:async';

import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondSplashPage extends StatefulWidget {
  const SecondSplashPage({super.key});

  @override
  State<SecondSplashPage> createState() => _SecondSplashPageState();
}

class _SecondSplashPageState extends State<SecondSplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.pushNamed(AppRoute.onboardingPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Image.asset(AppImages.splashImages),
        ),
      ),
    );
  }
}
