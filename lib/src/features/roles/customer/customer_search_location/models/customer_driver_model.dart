import 'customer_ride_model.dart';

class CustomerDriverModel {
  final String id;
  final String name;
  final String rating;
  final List<String> recommendations;
  final CustomerRideModel ride;

  CustomerDriverModel(
      {required this.id,
      required this.name,
      required this.rating,
      required this.recommendations,
      required this.ride});
}
