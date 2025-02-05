import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:eagle_cars/src/common/utils/validations.dart';
import 'package:eagle_cars/src/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../../../../../common/widgets/custom_elevated_button.dart';

class PromoCodeBottomSheet extends StatefulWidget {
  const PromoCodeBottomSheet({super.key});

  @override
  State<PromoCodeBottomSheet> createState() => _PromoCodeBottomSheetState();
}

class _PromoCodeBottomSheetState extends State<PromoCodeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final codeController = TextEditingController();

    return GestureDetector(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: colorScheme(context).outline.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text(
                      "Promo Code",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: context.pop,
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formkey,
                  child: CustomTextFormField(
                    controller: codeController,
                    hint: 'Input promo code',
                    prefixIconConstraints: const BoxConstraints(maxWidth: 30),
                    prefixIcon: SvgPicture.asset(
                      AppIcons.couponIcon,
                      colorFilter: ColorFilter.mode(
                          colorScheme(context).primary, BlendMode.srcIn),
                    ),
                    validator: (value) =>
                        Validation.fieldValidation(value, 'promo code'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      showSnackbar(message: 'Code Applied');
                      context.pop();
                    }
                  },
                  text: 'Apply',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
