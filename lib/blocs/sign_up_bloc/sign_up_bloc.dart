import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../../util/validators.dart';
import '../sign_up_bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SignUpState get initialState => SignUpState.empty();

  @override
  Stream<SignUpState> transformEvents(
    Stream<SignUpEvent> events,
    Stream<SignUpState> Function(SignUpEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! NameChanged &&
          event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! PhoneNumberChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NameChanged ||
          event is EmailChanged ||
          event is PasswordChanged ||
          event is PhoneNumberChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PhoneNumberChanged) {
      yield* _mapPhoneNumberChangedToState(event.phoneNumber);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.user);
    }
  }

  Stream<SignUpState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isPasswordValid: name.isNotEmpty,
    );
  }

  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpState> _mapPhoneNumberChangedToState(String phoneNumber) async* {
    yield state.update(
      isPhoneNumberValid: Validators.isValidPhoneNumber(phoneNumber),
    );
  }

  Stream<SignUpState> _mapFormSubmittedToState(User user) async* {
    yield SignUpState.loading();
    try {
      await _userRepository.signUp(user);
      yield SignUpState.success();
    } catch (err) {
      print(err);
      yield SignUpState.failure();
    }
  }
}
