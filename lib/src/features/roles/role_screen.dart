import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/common/widgets/custom_elevated_button.dart';
import 'package:eagle_cars/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chose your Role",
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: CustomElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.loginPage);
                    },
                    text: "Customer"),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: CustomElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.driverLoginPage);
                    },
                    text: "Driver"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
