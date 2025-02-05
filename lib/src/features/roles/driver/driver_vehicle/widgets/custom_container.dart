import '/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomContainer({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Bottom padding
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colorScheme(context)
                    .outline
                    .withOpacity(0.4), // Shadow color with opacity
                offset: const Offset(
                    3, 3), // Adjusted offset to shift shadow right and bottom
                blurRadius: 6, // Spread of the shadow
              ),
            ],
          ),

          alignment: Alignment.centerLeft, // Aligns the text to the left
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0), // Horizontal padding for the text
          child: Text(
            text,
            style: textTheme(context)
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
