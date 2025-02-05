import 'package:flutter/material.dart';

import '../../../../../common/constants/global_variable.dart';

class DriverCarouselDebitCard extends StatelessWidget {
  final String cardNumber;
  final String cardType;
  final String expiry;

  const DriverCarouselDebitCard({
    super.key,
    required this.cardNumber,
    required this.cardType,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme(context).primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cardNumber,
                style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                '$cardType $expiry',
                style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.remove_circle,
                color: colorScheme(context).onPrimary),
            onPressed: () {
              // Add card removal logic here
            },
          ),
        ],
      ),
    );
  }
}
