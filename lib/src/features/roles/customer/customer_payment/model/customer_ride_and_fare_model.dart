class CustomerRideAndFareModel {
  String? toyota;
  String? eta;
  String? baseFare;
  String? taxesFees;
  String? promoApplied;
  String? total;

  CustomerRideAndFareModel(
      {this.toyota,
      this.eta,
      this.baseFare,
      this.taxesFees,
      this.promoApplied,
      this.total});
}

List<CustomerRideAndFareModel> rideSummary = [
  CustomerRideAndFareModel(
    toyota: '123 Main St.',
    eta: '2 minutes',
  )
];

List<CustomerRideAndFareModel> fareBreakdown = [
  CustomerRideAndFareModel(
    baseFare: '\$25.00',
    taxesFees: '\$1.50',
    promoApplied: '\$2.00',
    total: '\$28.50',
  )
];