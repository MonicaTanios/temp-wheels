class Rental {
  String id;
  String userId;
  String vehicleId;
  String visaNumber;
  String startDate;
  String endDate;
  double rentFees;

  Rental({this.id, this.userId, this.vehicleId, this.visaNumber,
      this.startDate, this.endDate, this.rentFees});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'rentFees': rentFees
    };
  }

  @override
  String toString() {
    return '''Rental {
      'id': $id,
      userId: $userId,
      vehicleId: $vehicleId,
      startDate: $startDate,
      endDate: $endDate,
      rentFees: $rentFees,
    }''';
  }
}
