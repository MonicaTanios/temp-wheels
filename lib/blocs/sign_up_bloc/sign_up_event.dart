import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends SignUpEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name: $name }';
}

class EmailChanged extends SignUpEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const PhoneNumberChanged({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'PhoneNumberChanged { password: $phoneNumber }';
}

class Submitted extends SignUpEvent {
  final User user;

  const Submitted({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Submitted { user: $user }';
}
