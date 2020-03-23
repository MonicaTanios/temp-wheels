import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../widgets/rectangular_button.dart';

class VehicleScreen extends StatelessWidget {
  final Vehicle vehicle;

  VehicleScreen(this.vehicle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.model),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              vehicle.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Capacity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${vehicle.capacity} persons"),
            SizedBox(height: 16),
            Text(
              "Fees",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${vehicle.dailyFees} EGP/day"),
            SizedBox(height: 64),
            Center(
              child: RectangularButton(
                text: 'Rent',
                textColor: Colors.white,
                onPressed: () {
                  // TODO: Handle Rent Pressed Here
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
