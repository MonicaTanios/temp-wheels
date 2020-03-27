import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/rental_bloc/bloc.dart';
import '../models/rental.dart';
import '../models/vehicle.dart';
import '../repositories/rental_repository.dart';
import '../widgets/rectangular_button.dart';
import '../widgets/rectangular_text_field.dart';

class RentalScreen extends StatelessWidget {
  final Vehicle vehicle;
  final RentalRepository _rentalRepository = RentalRepository();

  RentalScreen({Key key, @required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Screen'),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
          child: BlocProvider<RentalBloc>(
        create: (context) =>
            RentalBloc(rentalRepository: this._rentalRepository),
        child: RentalForm(this.vehicle),
      )),
    );
  }
}

class RentalForm extends StatefulWidget {
  final Vehicle vehicle;

  RentalForm(this.vehicle);
  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  final _visaNumberController = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  var selectedDate = DateTime.now();

  // ignore: non_constant_identifier_names
  RentalBloc _rentalBloc;

  bool get isPopulated => _visaNumberController.text.isNotEmpty;

  bool isRentalButtonEnabled(RentalState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _rentalBloc = BlocProvider.of<RentalBloc>(context);
    _visaNumberController.addListener(_onVisaNumberChanged);
    _startDate.text = 'Pick date ';
    _endDate.text = 'Pick date ';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RentalBloc, RentalState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Saving Data...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Rented'),
              ),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rental Failure'),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
      },
      child: BlocBuilder<RentalBloc, RentalState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(24.0),
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        RectangularTextField(
                          hintText: 'Visa Number',
                          controller: _visaNumberController,
                          suffixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.grey,
                          ),
                          obscureText: false,
                          validator: (_) {
                            return !state.isVisaNumberValid
                                ? 'Invalid Visa Number'
                                : null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 24),
                        RectangularButton(
                          buttonColor: Colors.white,
                          width: 147,
                          text: 'Choose Pickup Location',
                          onPressed: _launchURL,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 24),
                        RectangularButton(
                          buttonColor: Colors.white,
                          width: 147,
                          text: 'Choose Dropoff Location',
                          onPressed: _launchURL,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 50,
                                ),
                                RaisedButton(
                                  child: Text(_startDate.text.substring(0, 10)),
                                  onPressed: () {
                                    _selectDate(context, _startDate);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'End Date',
                                  style: TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 50,
                                ),
                                RaisedButton(
                                  child: Text(_endDate.text.substring(0, 10)),
                                  onPressed: () {
                                    _selectDate(context, _endDate);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        Text(
                          'Total Fees',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                        Text(
                          "${this.widget.vehicle.dailyFees}",
                          style: TextStyle(fontSize: 32.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        RectangularButton(
                          buttonColor: Colors.white,
                          width: 147,
                          text: 'Rent',
                          onPressed: isRentalButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _visaNumberController.dispose();
    _startDate.dispose();
    _endDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controller.text = selectedDate.toString();
      });
  }

  // Future<Null> _selectEndDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       _endDate.text = selectedDate.toString();
  //     });
  // }

  _launchURL() async {
    // TODO: Get vehicle position
    var url =
        'https://www.google.com/maps?sll=\$%7Btrip.origLocationObj.lat%7D,\$%7Btrip.origLocationObj.lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onVisaNumberChanged() {
    _rentalBloc.add(
      VisaNumberChanged(visaNumber: _visaNumberController.text),
    );
  }

  void _onFormSubmitted() {
    var authBloc = BlocProvider.of<AuthenticationBloc>(context);
    var state = authBloc.state as Authenticated;
    var user = state.user;
    Rental rental = Rental(
      userId: user.id,
      vehicleId: this.widget.vehicle.id,
      visaNumber: _visaNumberController.text,
      startDate: _startDate.text.substring(0, 10),
      endDate: _endDate.text.substring(0, 10),
      rentFees: this.widget.vehicle.dailyFees,
    );

    _rentalBloc.add(Submitted(rental: rental));
  }
}
