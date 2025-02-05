class BookingModel {
  final DateTime date;
  final String pickUp;
  final String dropOff;
  final double price;
  final String status;
  final String minsAgo ;

  BookingModel({
    required this.date,
    required this.pickUp,
    required this.dropOff,
    required this.price,
    required this.status,
    required this.minsAgo
  });
}