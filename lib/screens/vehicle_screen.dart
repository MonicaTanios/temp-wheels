import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/authentication_bloc/authentication_state.dart';
import '../models/user.dart';
import '../models/vehicle.dart';
import '../screens/rental_screen.dart';
import '../widgets/rectangular_button.dart';

class VehicleScreen extends StatefulWidget {
  Vehicle vehicle;
  VehicleScreen(this.vehicle);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthenticationBloc>(context);
    var state = authBloc.state as Authenticated;
    VehicleScreen(this.widget.vehicle);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle.model),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.vehicle.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Capacity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${widget.vehicle.capacity} persons"),
            SizedBox(height: 16),
            Text(
              "Fees",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${widget.vehicle.dailyFees} EGP/day"),
            SizedBox(height: 64),
            Center(
              child: RectangularButton(
                text: 'Rent',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RentalScreen(vehicle: this.widget.vehicle)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
