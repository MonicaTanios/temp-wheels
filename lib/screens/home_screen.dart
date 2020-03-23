import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';
import '../models/vehicle.dart';
import '../screens/vehicle_screen.dart';
import '../widgets/rectangular_button.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome ${user.name}!')),
          RectangularButton(
            text: 'Mimic Vehicle Pressed',
            textColor: Colors.white,
            onPressed: () {
              // TODO: Pass the clicked vehicle to VehicleScreen instead of tmp
              var tmp = Vehicle(
                  id: "0xFF",
                  model: "Just a Car",
                  description: "Lorem ipsum dolor sit amet, consectetur"
                      "adipiscing elit, sed do eiusmod tempor incididunt"
                      "ut labore et dolore magna aliqua."
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco"
                      "laboris nisi ut aliquip ex ea commodo consequat.",
                  capacity: 4,
                  dailyFees: 99.9,
                  isAvailable: true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VehicleScreen(tmp)),
              );
            },
          )
        ],
      ),
    );
  }
}
