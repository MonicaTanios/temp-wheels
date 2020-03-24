import 'package:meta/meta.dart';

@immutable
class RentalState {
  final bool isVisaNumberValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isVisaNumberValid;

  RentalState({
    @required this.isVisaNumberValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RentalState.empty() {
    return RentalState(
      isVisaNumberValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RentalState.loading() {
    return RentalState(
      isVisaNumberValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RentalState.failure() {
    return RentalState(
      isVisaNumberValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RentalState.success() {
    return RentalState(
      isVisaNumberValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RentalState update({
    bool isVisaNumberValid,
  }) {
    return copyWith(
      isVisaNumberValid: isVisaNumberValid,
      isSuccess: false,
      isFailure: false,
    );
  }

  RentalState copyWith({
    bool isVisaNumberValid,
    bool isSuccess,
    bool isFailure,
  }) {
    return RentalState(
      isVisaNumberValid: isVisaNumberValid ?? this.isVisaNumberValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RentalState {
      isVisaNumberValid: $isVisaNumberValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
