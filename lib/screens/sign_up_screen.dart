import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../widgets/rectangular_button.dart';
import '../widgets/rectangular_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SignUpScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(userRepository: _userRepository),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _phoneNumberController.addListener(_onPhoneNumberChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
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
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
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
                    color: Colors.white.withOpacity(0.0),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 48.0),
                          RectangularTextField(
                            controller: _nameController,
                            hintText: 'Full Name',
                            obscureText: false,
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            validator: (_) {
                              return !state.isNameValid ? 'Invalid Name' : null;
                            },
                          ),
                          SizedBox(height: 32.0),
                          RectangularTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            obscureText: false,
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                          ),
                          SizedBox(height: 32.0),
                          RectangularTextField(
                            controller: _passwordController,
                            hintText: 'P@s*w0r&',
                            obscureText: true,
                            suffixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                          ),
                          SizedBox(height: 32.0),
                          RectangularTextField(
                            controller: _phoneNumberController,
                            hintText: 'Phone Number',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Phone Number'
                                  : null;
                            },
                          ),
                          SizedBox(height: 48.0),
                          RectangularButton(
                            width: double.infinity,
                            buttonColor: Colors.purple[300],
                            textColor: Colors.white,
                            text: 'Sign Up',
                            onPressed: isSignUpButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                          )
                        ],
                      ),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _signUpBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onPhoneNumberChanged() {
    _signUpBloc.add(
      PhoneNumberChanged(phoneNumber: _phoneNumberController.text),
    );
  }

  void _onFormSubmitted() {
    User user = User(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNumber: _phoneNumberController.text,
      balance: 0,
    );

    _signUpBloc.add(Submitted(user: user));
  }
}
