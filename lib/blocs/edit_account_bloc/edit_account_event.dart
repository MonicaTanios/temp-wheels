import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();
  @override
  List<Object> get props => [];
}

class EmailChanged extends EditAccountEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class NewPasswordChanged extends EditAccountEvent {
  final String password;

  const NewPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'NewPasswordChanged { password: $password }';
}

class ConfirmPasswordChanged extends EditAccountEvent {
  final String password;
  final String confirmation;

  const ConfirmPasswordChanged(
      {@required this.password, @required this.confirmation});

  @override
  List<Object> get props => [password, confirmation];

  @override
  String toString() {
    return '''ConfirmPasswordChanged {
      password: $password,
      confirmation: $confirmation
    }''';
  }
}

class EmailSubmitted extends EditAccountEvent {
  final String oldEmail;
  final String password;
  final String newEmail;

  EmailSubmitted(
      {@required this.oldEmail,
      @required this.password,
      @required this.newEmail});

  @override
  List<Object> get props => [oldEmail, password, newEmail];

  @override
  String toString() {
    return '''EmailSubmitted { 
      oldEmail: $oldEmail,
      password: $password,
      newEmail: $newEmail
    }''';
  }
}

class PasswordSubmitted extends EditAccountEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  PasswordSubmitted(
      {@required this.email,
      @required this.oldPassword,
      @required this.newPassword});

  @override
  List<Object> get props => [email, oldPassword, newPassword];

  @override
  String toString() {
    return '''PasswordSubmitted { 
      email: $email,
      oldPassword: $oldPassword,
      newPassword: $newPassword
    }''';
  }
}
