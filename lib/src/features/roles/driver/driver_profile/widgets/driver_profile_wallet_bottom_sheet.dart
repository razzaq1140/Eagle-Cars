import '/src/common/constants/global_variable.dart';
import '/src/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class DriverWalletBottomSheet extends StatelessWidget {
  DriverWalletBottomSheet({
    super.key,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 493,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wallet Details',
              style: textTheme(context).headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Balance',
                  style: textTheme(context).headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).onSurface,
                        fontSize: 12,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme(context).primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'USD',
                        style: TextStyle(
                            color: colorScheme(context).onSurface,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '240.000',
                      style: textTheme(context).headlineMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).onSurface,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 121,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme(context).primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Last Transaction',
                            style: textTheme(context).headlineMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '50.00 USD',
                            style: textTheme(context).headlineMedium!.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 0.25),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.remove_circle,
                        color: colorScheme(context).onSurface,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
                CustomElevatedButton(onPressed: () {}, text: "Add Money"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
