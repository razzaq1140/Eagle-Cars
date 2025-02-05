import 'package:eagle_cars/src/common/constants/app_images.dart';

class CustomerChatModel {
  String message;
  String image;
  int senderId;
  bool isSentByMe;

  CustomerChatModel({
    required this.message,
    required this.image,
    required this.senderId,
    required this.isSentByMe,
  });
}

List<CustomerChatModel> messages = [
  CustomerChatModel(
      message: 'Hello, are you nearby?',
      senderId: 1,
      isSentByMe: true,
    image: NetworkImages.chatDp
  ),
  CustomerChatModel(
    message: 'Sorry, I’m stuck in traffiic pls give me a moment',
    senderId: 2,
    isSentByMe: false,
    image: 'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=600'
  ),
  CustomerChatModel(
    message: 'Ok, I’m waiting',
    senderId: 3,
    isSentByMe: true,
    image: NetworkImages.chatDp
  )
];