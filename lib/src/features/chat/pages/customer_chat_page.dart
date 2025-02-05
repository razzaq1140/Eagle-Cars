import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_cars/src/common/constants/app_images.dart';
import 'package:eagle_cars/src/common/constants/global_variable.dart';
import 'package:eagle_cars/src/features/chat/model/customer_chat_model.dart';
import 'package:eagle_cars/src/features/chat/widget/customer_chat_clipper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerChatPage extends StatefulWidget {
  const CustomerChatPage({super.key});

  @override
  State<CustomerChatPage> createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends State<CustomerChatPage> {
  final txtController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int senderId = 4;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: size.width * 0.5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Wrap(
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(Icons.arrow_back)),
              SizedBox(width: size.width * 0.03),
              const CircleAvatar(
                radius: 15,
                backgroundImage:
                    CachedNetworkImageProvider(NetworkImages.chatDp),
              ),
              SizedBox(width: size.width * 0.03),
              Text('Sule Abdul',
                  style: textTheme(context)
                      .titleMedium!
                      .copyWith(letterSpacing: 0)),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Row(
                  mainAxisAlignment: message.isSentByMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!message.isSentByMe) ...[
                      CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(message.image),
                      ),
                      const SizedBox(width: 8),
                    ],
                    ClipPath(
                      clipper: CustomerChatClipper(message.isSentByMe),
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        padding: message.isSentByMe
                            ? const EdgeInsets.all(6)
                            : const EdgeInsets.only(
                                left: 25, top: 6, bottom: 6, right: 6),
                        color: message.isSentByMe
                            ? colorScheme(context).primary
                            : Colors.grey[300],
                        child: Text(
                          message.message,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Container(
                    //   width: 200,
                    //   margin: const EdgeInsets.all(5),
                    //   padding: const EdgeInsets.all(10),
                    //   color: message.isSentByMe
                    //       ? colorScheme(context).primary
                    //       : Colors.grey[300],
                    //   child: Text(
                    //     message.message,
                    //   ),
                    // ),
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
                        messages.add(CustomerChatModel(
                          message: txtController.text,
                          senderId: senderId++,
                          image: NetworkImages.chatDp,
                          isSentByMe: true,
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
