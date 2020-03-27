import 'package:meta/meta.dart';

@immutable
class EditAccountState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  EditAccountState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isConfirmPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory EditAccountState.empty() {
    return EditAccountState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditAccountState.loading() {
    return EditAccountState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditAccountState.failure() {
    return EditAccountState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory EditAccountState.success() {
    return EditAccountState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  EditAccountState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  EditAccountState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return EditAccountState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''EditAccountState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isConfirmPasswordValid: $isConfirmPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
