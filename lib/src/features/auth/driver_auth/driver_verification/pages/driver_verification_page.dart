import 'dart:async';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DriverVerificationPage extends StatefulWidget {
  const DriverVerificationPage({super.key});

  @override
  State<DriverVerificationPage> createState() => _DriverVerificationPageState();
}

class _DriverVerificationPageState extends State<DriverVerificationPage> {
  String? verificationCode = '';
  int startTime = 120; // 2 minutes countdown
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown timer when the page loads
  }

  // Timer function to countdown every second
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTime > 0) {
        setState(() {
          startTime--;
        });
      } else {
        _timer.cancel(); // Stop the timer when it reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification',
              style: textTheme(context)
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            const SizedBox(height: 100),
            OtpTextField(
              numberOfFields: 4,
              showFieldAsBox: true,
              fieldWidth: 50,
              textStyle:
                  textTheme(context).titleLarge!.copyWith(letterSpacing: 0),
              borderColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onCodeChanged: (String code) {
                // Handle validation or checks here
              },
              onSubmit: (String code) {
                setState(() {
                  verificationCode = code;
                });
                if (verificationCode?.isEmpty ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('OTP cannot be empty')),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.clockIcon,
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  child: Text(
                      '${(startTime ~/ 60).toString().padLeft(2, '0')}:${(startTime % 60).toString().padLeft(2, '0')}',
                      style: textTheme(context)
                          .labelMedium!
                          .copyWith(letterSpacing: 0)),
                )
              ],
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
                onPressed: () {
                  if (verificationCode?.isEmpty ?? false) {
                   
                    showSnackbar(
                                message: 'Please enter OTP',
                                isError: true);
                  } else {
                    context.pushNamed(AppRoute.driverUpdatePasswordPage);
                    _timer.cancel();
                   setState(() {
                   startTime = 0;

                   });
                  }
                },
                text: 'Verify OTP'),
            const SizedBox(height: 15),
            Center(
                child: Text('Request new otp',
                    style: textTheme(context)
                        .labelLarge!
                        .copyWith(letterSpacing: 0))),
          ],
        ),
      ),
    );
  }
}
