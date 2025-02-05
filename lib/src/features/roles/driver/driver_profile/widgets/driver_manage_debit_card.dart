import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common/constants/global_variable.dart';
import '../../driver_mobile_money_account/pages/mobile_money_page.dart';
import 'add_new_card.dart';
import 'driver_carousel_debit_card.dart';

class DriverManageDebitCardsSheet extends StatefulWidget {
  const DriverManageDebitCardsSheet({super.key});

  @override
  State<DriverManageDebitCardsSheet> createState() =>
      _DriverManageDebitCardsSheetState();
}

class _DriverManageDebitCardsSheetState
    extends State<DriverManageDebitCardsSheet> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Text('Manage debit cards',
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: colorScheme(context).onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 22)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: PageView(
                controller: _pageController,
                children: const [
                  DriverCarouselDebitCard(
                      cardNumber: '**** **** **** 657',
                      cardType: 'MasterCard',
                      expiry: 'MAR/2020'),
                  DriverCarouselDebitCard(
                      cardNumber: '**** **** **** 123',
                      cardType: 'Visa',
                      expiry: 'DEC/2023'),
                  DriverCarouselDebitCard(
                      cardNumber: '**** **** **** 456',
                      cardType: 'Visa',
                      expiry: 'DEC/2022'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: colorScheme(context).primary,
                  dotColor: colorScheme(context).outline,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddNewCard());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme(context).primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Add New Card',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const MobileMoneyPage());
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: BorderSide(color: colorScheme(context).primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Add Mobile Money Account',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
