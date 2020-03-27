import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import '../../repositories/user_repository.dart';
import '../../util/validators.dart';
import '../edit_account_bloc/bloc.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  final UserRepository _userRepository;

  EditAccountBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  EditAccountState get initialState => EditAccountState.empty();

  @override
  Stream<EditAccountState> transformEvents(
    Stream<EditAccountEvent> events,
    Stream<EditAccountState> Function(EditAccountEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged &&
          event is! NewPasswordChanged &&
          event is! ConfirmPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged ||
          event is NewPasswordChanged ||
          event is ConfirmPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<EditAccountState> mapEventToState(
    EditAccountEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is NewPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.password, event.confirmation);
    } else if (event is EmailSubmitted) {
      yield* _mapEmailSubmittedToState(
          event.oldEmail, event.password, event.newEmail);
    } else if (event is PasswordSubmitted) {
      yield* _mapPasswordSubmittedToState(
          event.email, event.oldPassword, event.newPassword);
    }
  }

  Stream<EditAccountState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<EditAccountState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<EditAccountState> _mapConfirmPasswordChangedToState(
      String password, String confirmation) async* {
    yield state.update(
      isConfirmPasswordValid: password == confirmation,
    );
  }

  Stream<EditAccountState> _mapEmailSubmittedToState(
      String oldEmail, String oldPassword, String newEmail) async* {
    yield EditAccountState.loading();
    try {
      await _userRepository.updateEmail(oldEmail, oldPassword, newEmail);
      yield EditAccountState.success();
    } catch (err) {
      print(err);
      yield EditAccountState.failure();
    }
  }

  Stream<EditAccountState> _mapPasswordSubmittedToState(
      String email, String oldPassword, String newEmail) async* {
    yield EditAccountState.loading();
    try {
      await _userRepository.updatePassword(email, oldPassword, newEmail);
      yield EditAccountState.success();
    } catch (err) {
      print(err);
      yield EditAccountState.failure();
    }
  }
}
