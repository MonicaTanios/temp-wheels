import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPhoneNumberValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isNameValid && isEmailValid && isPasswordValid && isPhoneNumberValid;

  SignUpState({
    @required this.isNameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isPhoneNumberValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumberValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumberValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumberValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumberValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignUpState update({
    bool isNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPhoneNumberValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPhoneNumberValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isNameValid: $isNameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isPhoneNumberValid: $isPhoneNumberValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
