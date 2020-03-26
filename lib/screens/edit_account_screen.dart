import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/edit_account_bloc/bloc.dart';
import '../models/user.dart';
import '../widgets/rectangular_button.dart';
import '../widgets/rectangular_text_field.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccountScreen> {
  final _emailController = new TextEditingController();
  final _oldPasswordController = new TextEditingController();
  final _newPasswordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  EditAccountBloc _editAccountBloc;
  User _user;

  bool get isEmailChanged =>
      _emailController.text.isNotEmpty && _emailController.text != _user.email;

  bool get isOldPasswordFilled => _oldPasswordController.text.isNotEmpty;

  bool get isPasswordChanged =>
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isUpdateAccountButtonEnabled(EditAccountState state) {
    return ((isEmailChanged && isOldPasswordFilled && state.isEmailValid) ||
            (isOldPasswordFilled &&
                isPasswordChanged &&
                state.isConfirmPasswordValid &&
                state.isPasswordValid)) &&
        !state.isSubmitting;
  }

  @override
  void initState() {
    _editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    var authState =
        BlocProvider.of<AuthenticationBloc>(context).state as Authenticated;

    _user = authState.user;

    super.initState();
    _emailController.text = _user.email;
    _emailController.addListener(_onEmailChanged);
    _newPasswordController.addListener(_onNewPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Account"),
        ),
        body: BlocListener(
            bloc: _editAccountBloc,
            listener: (context, state) {
              if (state.isSubmitting) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Updating...'),
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
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Account Updated!')],
                      ),
                    ),
                  );
                _user.email = _emailController.text;
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
                          Text('Edit Account Failure'),
                          Icon(Icons.error),
                        ],
                      ),
                    ),
                  );
              }
            },
            child: BlocBuilder<EditAccountBloc, EditAccountState>(
                builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      RectangularTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        obscureText: false,
                        suffixIcon: Icon(Icons.email),
                        hintText: "New Email",
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                      SizedBox(height: 16),
                      RectangularTextField(
                        keyboardType: TextInputType.text,
                        controller: _oldPasswordController,
                        obscureText: true,
                        suffixIcon: Icon(Icons.vpn_key),
                        hintText: "Old Password",
                      ),
                      SizedBox(height: 16),
                      RectangularTextField(
                        keyboardType: TextInputType.text,
                        controller: _newPasswordController,
                        obscureText: true,
                        suffixIcon: Icon(Icons.lock_outline),
                        hintText: "New Password",
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                      SizedBox(height: 16),
                      RectangularTextField(
                        keyboardType: TextInputType.text,
                        controller: _confirmPasswordController,
                        obscureText: true,
                        suffixIcon: Icon(Icons.lock_open),
                        hintText: "Confirm Password",
                        validator: (_) {
                          return !state.isConfirmPasswordValid
                              ? 'Invalid Password Confirmation'
                              : null;
                        },
                      ),
                      SizedBox(height: 48.0),
                      RectangularButton(
                        width: double.infinity,
                        buttonColor: Colors.purple[300],
                        textColor: Colors.white,
                        text: 'Update Credentials',
                        onPressed: isUpdateAccountButtonEnabled(state)
                            ? _onUpdateAccountButtonPressed
                            : null,
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _onEmailChanged() {
    _editAccountBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onNewPasswordChanged() {
    _editAccountBloc.add(
      NewPasswordChanged(password: _newPasswordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _editAccountBloc.add(
      ConfirmPasswordChanged(
          password: _newPasswordController.text,
          confirmation: _confirmPasswordController.text),
    );
  }

  void _onUpdateAccountButtonPressed() {
    if (isEmailChanged) {
      _editAccountBloc.add(EmailSubmitted(
          oldEmail: _user.email,
          password: _oldPasswordController.text,
          newEmail: _emailController.text));
    }

    if (isPasswordChanged) {
      _editAccountBloc.add(PasswordSubmitted(
          email: _emailController.text,
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text));
    }
  }
}
