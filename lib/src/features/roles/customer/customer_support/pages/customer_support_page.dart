import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../driver/driver_customer_support/model/customer_support_model.dart';

class CustomerSupportPage extends StatefulWidget {
  const CustomerSupportPage({super.key});

  @override
  State<CustomerSupportPage> createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> {
  final txtController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int senderId = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Support',
                style: textTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 24)),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: csMessages.length,
                itemBuilder: (context, index) {
                  final message = csMessages[index];
                  return Row(
                    mainAxisAlignment: message.isSentByMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!message.isSentByMe) ...[
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            AppIcons.csProfile,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Container(
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        color: message.isSentByMe
                            ? Colors.grey[300]
                            : colorScheme(context).primary,
                        child: Text(
                          message.message,
                        ),
                      ),
                      if (message.isSentByMe) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(message.image),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                controller: txtController,
                decoration: InputDecoration(
                  hintText: 'Enter message...',
                  hintStyle:
                      textTheme(context).labelLarge!.copyWith(letterSpacing: 0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: colorScheme(context).primary,
                      size: 30,
                    ),
                    onPressed: () {
                      if (txtController.text.isNotEmpty) {
                        setState(() {
                          csMessages.add(CustomerSupportModel(
                            message: txtController.text,
                            senderId: senderId++,
                            image: NetworkImages.chatDp,
                            isSentByMe: false,
                          ));
                        });
                        txtController.clear();
                        _scrollToBottom();
                      }
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    txtController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class CustomChatClipper extends CustomClipper<Path> {
  CustomChatClipper();

  @override
  Path getClip(Size size) {
    var path = Path();
    double bubbleTipWidth = 25.0;
    // Bubble with tip on the left
    path.moveTo(0, bubbleTipWidth);
    path.lineTo(bubbleTipWidth, bubbleTipWidth);
    path.lineTo(0, size.height / 2);
    path.lineTo(bubbleTipWidth, size.height - 5);
    path.lineTo(bubbleTipWidth, size.height);
    path.lineTo(bubbleTipWidth, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomChatClipper oldClipper) {
    return false;
  }
}
