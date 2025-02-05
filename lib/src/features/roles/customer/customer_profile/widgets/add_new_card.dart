import '../../../../../common/constants/global_variable.dart';
import 'package:flutter/material.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Add New Card',
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Card(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: colorScheme(context).onPrimary,
                      hintStyle: textTheme(context)
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 13),
                      hintText: 'Card Number',
                      prefixText: '         '),
                ),
              ),
              const SizedBox(height: 15),
              Card(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: colorScheme(context).onPrimary,
                      hintStyle: textTheme(context)
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 13),
                      hintText: 'Account Holder Name',
                      prefixText: '         '),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Card(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: colorScheme(context).onPrimary,
                            hintStyle: textTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 13),
                            hintText: 'Expiry Date',
                            prefixText: '         '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: Card(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: colorScheme(context).onPrimary,
                            hintStyle: textTheme(context).bodyMedium?.copyWith(
                                color: colorScheme(context).onPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                            hintText: 'CVV',
                            prefixText: '         '),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme(context).primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: colorScheme(context).primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
