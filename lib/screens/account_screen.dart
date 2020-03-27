import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/edit_account_bloc/bloc.dart';
import '../repositories/user_repository.dart';
import 'edit_account_screen.dart';

class AccoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authState =
        BlocProvider.of<AuthenticationBloc>(context).state as Authenticated;
    var _user = authState.user;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<EditAccountBloc>(
                    create: (context) =>
                        EditAccountBloc(userRepository: UserRepository()),
                    child: EditAccountScreen()),
              ));
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.person_pin,
                    color: Colors.blue,
                    size: 128,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      _user.name,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                          fontSize: 32),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      _user.email,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.timeline,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "101",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.stars,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "4.8",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Rentals",
                    style: TextStyle(fontSize: 24, color: Colors.blue[800]),
                  ),
                ),
              ),
              Expanded(
                //TODO: Fetch Rental history and fill the list
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text("Rental 1"),
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text("Rental 2"),
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text("Rental 3"),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
