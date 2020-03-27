import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../rental_bloc/rental_event.dart';
import '../rental_bloc/rental_state.dart';
import '../../models/rental.dart';
import '../../repositories/rental_repository.dart';
import '../../util/validators.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final RentalRepository _rentalRepository;

  RentalBloc({@required RentalRepository rentalRepository})
      : assert(RentalRepository != null),
        _rentalRepository = rentalRepository;

  @override
  RentalState get initialState => RentalState.empty();

  @override
  Stream<RentalState> transformEvents(
    Stream<RentalEvent> events,
    Stream<RentalState> Function(RentalEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! VisaNumberChanged);
    });
    final debounceStream = events.where((event) {
      return (event is VisaNumberChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RentalState> mapEventToState(RentalEvent event) async* {
    if (event is VisaNumberChanged) {
      yield* _mapVisaNumberChangedToState(event.visaNumber);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.rental);
    }
  }

  Stream<RentalState> _mapVisaNumberChangedToState(String visaNumber) async* {
    yield state.update(
      isVisaNumberValid: Validators.isValidVisaNumber(visaNumber),
    );
  }

  Stream<RentalState> _mapFormSubmittedToState(Rental rental) async* {
    yield RentalState.loading();
    try {
      await _rentalRepository.saveRentalData(rental);
      yield RentalState.success();
    } catch (err) {
      print(err);
      yield RentalState.failure();
    }
  }
}
