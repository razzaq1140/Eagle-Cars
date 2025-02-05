import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/features/onborading/model/onboarding_model.dart';
import 'package:eagle_cars/src/features/onborading/provider/onboarding_provider.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      context.read<PageIndexProvider>().setPageIndex(controller.page!.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentIndex = context.watch<PageIndexProvider>().currentIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.76,
              child: PageView.builder(
                controller: controller,
                itemCount: onBoardingData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final onboardingData = onBoardingData[index];
                  return Column(
                    children: [
                      ClipPath(
                        clipper: onboardingData.clipper,
                        child: Container(
                          height: 200,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        onboardingData.image,
                        height: 200,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          onboardingData.title,
                          style: textTheme(context)
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          onboardingData.subTitle,
                          textAlign: TextAlign.center,
                          style: textTheme(context).bodyLarge?.copyWith(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 20,
                  height: 8,
                  color: colorScheme(context).primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                dotDecoration: DotDecoration(
                  width: 8,
                  height: 8,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex < 2)
                    TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoute.rolePage);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  if (currentIndex == 3)
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context.pushNamed(AppRoute.rolePage);
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: colorScheme(context).onPrimary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppIcons.sendIcon),
                                  const SizedBox(width: 10),
                                  Text('Use current location',
                                      style: textTheme(context)
                                          .titleSmall!
                                          .copyWith(
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            child: Text(
                              'Select it manually',
                              style: textTheme(context).labelLarge!.copyWith(
                                  letterSpacing: 0,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: (){},
                          )
                        ],
                      ),
                    )
                  else
                    Expanded(
                      flex: currentIndex == 2 ? 1 : 0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentIndex < onBoardingData.length - 1) {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
