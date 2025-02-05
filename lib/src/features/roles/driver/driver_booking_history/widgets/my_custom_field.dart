import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class MyCustomField extends StatefulWidget {
  const MyCustomField({super.key});

  @override
  State<MyCustomField> createState() => _MyCustomFieldState();
}

class _MyCustomFieldState extends State<MyCustomField> {
  @override
  Widget build(BuildContext context) {
    TextStyle hint = textTheme(context)
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w300, fontSize: 15);
    return SizedBox(
      height: 60,
      child: Card(
        color: colorScheme(context).surface,
        elevation: 2,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_sharp,
              color: colorSchemeLight.onPrimary.withOpacity(0.3),
            ),
            border: InputBorder.none,
            hintText: 'where would you like to go',
            hintStyle: hint,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
