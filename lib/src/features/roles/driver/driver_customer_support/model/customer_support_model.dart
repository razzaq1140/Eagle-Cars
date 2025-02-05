import 'package:eagle_cars/src/common/constants/app_images.dart';

class CustomerSupportModel {
  String message;
  String image;
  int senderId;
  bool isSentByMe;

  CustomerSupportModel({
    required this.message,
    required this.image,
    required this.senderId,
    required this.isSentByMe,
  });
}

List<CustomerSupportModel> csMessages = [
  CustomerSupportModel(
      message: 'Hi, how can I help you?',
      senderId: 1,
      isSentByMe: false,
    image: NetworkImages.chatDp
  ),
];