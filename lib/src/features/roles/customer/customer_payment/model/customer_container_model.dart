import 'package:eagle_cars/src/common/constants/app_images.dart';

class CustomerContainerModel{
  String image;
  String cardNumber;
  String doneIcon;
  CustomerContainerModel({required this.image,required this.cardNumber,required this.doneIcon});
}

List<CustomerContainerModel> cardData = [
  CustomerContainerModel(
      image: AppIcons.visa,
      cardNumber: '**** **** **** 5967',
      doneIcon: AppIcons.done
  ),
  CustomerContainerModel(
      image: AppIcons.paypal,
      cardNumber: 'wilson.casper@bernice.info',
      doneIcon: AppIcons.done
  ),
  CustomerContainerModel(
      image: AppIcons.visa,
      cardNumber: '**** **** **** 3461',
      doneIcon: AppIcons.done
  )
];