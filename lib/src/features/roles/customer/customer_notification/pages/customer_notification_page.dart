import 'package:eagle_cars/src/common/utils/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/constants/app_images.dart';
import '../../../../../common/constants/global_variable.dart';
import '../models/notification_model.dart';

class CustomerNotificationPage extends StatefulWidget {
  CustomerNotificationPage({super.key});

  @override
  State<CustomerNotificationPage> createState() => _CustomerNotificationPageState();
}

class _CustomerNotificationPageState extends State<CustomerNotificationPage> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      type: "Ride Completed",
      title: "Your Ride With Driver Alex Was Completed Successfully.",
      timeAgo: "2 Min Ago",
      icon: AppIcons.checkMark, // Replace with actual icons
    ),
    NotificationModel(
      type: "Driver Arrived",
      title: "Your Driver Has Arrived At Your Pickup Location.",
      timeAgo: "10 Min Ago",
      icon: AppIcons.car,
    ),
    NotificationModel(
      type: "Promotion",
      title: "Get 15% Off On Your Next Ride!",
      timeAgo: "1 Hour Ago",
      icon: AppIcons.alertCar,
    ),
    NotificationModel(
      type: "Safety Alert",
      title: "New Safety Feature Added. Check It Out!",
      timeAgo: "Yesterday",
      icon: AppIcons.promotionHand,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      
        actions: [

          IconButton(
            icon: Icon(
              CupertinoIcons.delete,
              color: colorScheme(context).error,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                showMyDialog();
                   // Delete the first item
                });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: textTheme(context).headlineMedium?.copyWith(
                  fontSize: 24,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Dismissible(
                    key: Key(notification.title),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                      showSnackbar(message: 'Notification deleted',isError: true);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(2),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(2))),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.notificationIcon,
                                  width: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Notification",
                                  style: textTheme(context).bodySmall,
                                ),
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  notification.icon,
                                  width: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  notification.type,
                                  style: textTheme(context).bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              notification.title,
                              style: textTheme(context)
                                  .bodyLarge
                                  ?.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.timeCircle,
                                  width: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  notification.timeAgo,
                                  style: textTheme(context).bodyLarge?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
   showMyDialog() async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Do you want to delete all notification?',
              style: textTheme(context).titleLarge?.copyWith(letterSpacing: 0),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'No',
              style: textTheme(context).titleMedium?.copyWith(color: colorScheme(context).error),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'Yes',
              style: textTheme(context).titleMedium?.copyWith(color: colorScheme(context).secondary),
            ),
          ),
        ],
      );
    },
  );
}

}
