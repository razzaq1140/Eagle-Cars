import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverSuccessfullyPage extends StatefulWidget {
  const DriverSuccessfullyPage({super.key});

  @override
  State<DriverSuccessfullyPage> createState() => _SuccessfullyPageState();
}

class _SuccessfullyPageState extends State<DriverSuccessfullyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(AppIcons.dialogIcon)),
            const SizedBox(height: 20),
            Text(
              'Successfully!',
              style: textTheme(context)
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            const SizedBox(height: 15),
            Text(
                textAlign: TextAlign.center,
                'look like readable English. Many desktop publishing packages and web page editors now',
                style: textTheme(context).bodyLarge!.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.4),
                      letterSpacing: 0,
                      fontSize: 17,
                    )),
            const SizedBox(height: 15),
            CustomElevatedButton(
                onPressed: () => MyAppRouter.clearAndNavigate(
                    context, AppRoute.driverLoginPage),
                text: 'Done'),
          ],
        ),
      ),
    );
  }
}
