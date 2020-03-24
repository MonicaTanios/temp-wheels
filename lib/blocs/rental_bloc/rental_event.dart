import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/rental.dart';

abstract class RentalEvent extends Equatable {
  const RentalEvent();

  @override
  List<Object> get props => [];
}

class VisaNumberChanged extends RentalEvent {
  final String visaNumber;

  const VisaNumberChanged({@required this.visaNumber});

  @override
  List<Object> get props => [visaNumber];

  @override
  String toString() => 'VisaNumberChanged { visaNumber: $visaNumber }';
}

class Submitted extends RentalEvent {
  final Rental rental;

  const Submitted({@required this.rental});

  @override
  List<Object> get props => [rental];

  @override
  String toString() => 'Submitted { rental: $rental }';
}
