import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/customer_container_model.dart';
import '../model/customer_ride_and_fare_model.dart';
import '../provider/customer_container_provider.dart';

class CustomerPaymentScreen extends StatefulWidget {
  const CustomerPaymentScreen({super.key});

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Method',
                style: textTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorScheme(context).surface,
                  boxShadow: [
                    BoxShadow(
                        color: colorScheme(context).outline.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(2, 5))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CREDIT CARD',
                      style: textTheme(context)
                          .bodyLarge!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cardData.length,
                    itemBuilder: (context, index) {
                      final data = cardData[index];
                      return customCardContainer(
                          cardPic: data.image,
                          cardNumber: data.cardNumber,
                          doneIcon: data.doneIcon,
                          index: index);
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text('Ride Summary',
                style: textTheme(context)
                    .bodyLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: rideSummary.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = rideSummary[index];
                return Column(
                  children: [
                    customRowWidget(
                        name: 'Toyota Prius-Black',
                        title: data.toyota.toString()),
                    customRowWidget(name: 'ETA', title: data.eta.toString()),
                    Divider(
                      color: colorScheme(context).outline,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 15),
            Text('Fare Breakdown',
                style: textTheme(context)
                    .bodyLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: fareBreakdown.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = fareBreakdown[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customRowWidget(
                        name: 'Base Fare', title: data.baseFare.toString()),
                    customRowWidget(
                        name: 'Taxes & Fees', title: data.taxesFees.toString()),
                    customRowWidget(
                        name: 'Promo Applied',
                        title: data.promoApplied.toString()),
                    customRowWidget(
                        name: 'Total', title: data.total.toString()),
                    Divider(
                      color: colorScheme(context).outline,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Promo Code or Discount',
                        style: textTheme(context).bodyLarge!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FIRSTRIDE',
                          style: textTheme(context).labelMedium!.copyWith(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                              color: colorScheme(context).outline),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: colorScheme(context).primary,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            'Applied',
                            style: textTheme(context).labelMedium!.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: colorScheme(context).onPrimary),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: colorScheme(context).outline,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.pop();
                          },
                          child: Text(
                            'Cancel',
                            style: textTheme(context).titleMedium!.copyWith(
                                letterSpacing: 0,
                                color: colorScheme(context).outline),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: colorScheme(context).primary,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              'Confirm Payment',
                              style: textTheme(context).titleMedium!.copyWith(
                                  letterSpacing: 0,
                                  color: colorScheme(context).onPrimary),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget customCardContainer({
    required String cardPic,
    required String cardNumber,
    required String doneIcon,
    required int index,
  }) {
    final provider =
        Provider.of<CustomerContainerProvider>(context).containerIndex;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<CustomerContainerProvider>(context, listen: false)
              .selectCard(index);
        },
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: colorScheme(context).outline.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: provider == index
                  ? colorScheme(context)
                      .primary // Change this to your desired selected border color
                  : Colors.transparent, // No border if not selected
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: SvgPicture.asset(cardPic),
            title: Text(cardNumber),
            trailing: SvgPicture.asset(doneIcon,
                color: provider == index
                    ? colorScheme(context).primary
                    : Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget customRowWidget({required String name, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: textTheme(context).labelMedium!.copyWith(
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
                color: colorScheme(context).outline),
          ),
          Text(
            title,
            style: textTheme(context).labelMedium!.copyWith(
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
                color: colorScheme(context).onPrimary),
          ),
        ],
      ),
    );
  }
}
