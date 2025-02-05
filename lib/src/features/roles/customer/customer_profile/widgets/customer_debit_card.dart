import 'package:flutter/material.dart';
import '../../../../../common/constants/global_variable.dart';


class CardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardType;
  final String expiry;

  const CardWidget({
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
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cardNumber,
            style: textTheme(context).bodyMedium?.copyWith(
                color: colorScheme(context).onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            '$cardType $expiry',
            style: textTheme(context).bodyMedium?.copyWith(
                color: colorScheme(context).onPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon:
              Icon(Icons.remove_circle, color: colorScheme(context).onPrimary),
              onPressed: () {
                // Add card removal logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}
