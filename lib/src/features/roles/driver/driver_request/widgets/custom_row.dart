import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final Icon? icon;
  final String? title;
  final Color? color;
  const CustomRow({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon!,
        const SizedBox(
          width: 10,
        ),
        Text(
          title!,
          style: textTheme(context).bodySmall!.copyWith(
              fontSize: 13,
              letterSpacing: 0,
              color: colorScheme(context).surface,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
