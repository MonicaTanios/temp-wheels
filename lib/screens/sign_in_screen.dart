import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sing_in_bloc/bloc.dart';
import '../repositories/user_repository.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/rectangular_button.dart';
import '../widgets/rectangular_text_field.dart';

class SignInScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SignInScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: _userRepository),
        child: SignInForm(userRepository: _userRepository),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignInForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SignInBloc _signInBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignInButtonEnabled(SignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
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
                    color: Colors.white.withOpacity(
                      0.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 180.0),
                          CircleAvatar(
                            child: Image.asset('assets/logo.png'),
                            backgroundColor: Colors.transparent,
                            radius: 64,
                          ),
                          SizedBox(height: 48.0),
                          RectangularTextField(
                            hintText: 'example@gmail.com',
                            controller: _emailController,
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            obscureText: false,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                          ),
                          SizedBox(height: 24.0),
                          RectangularTextField(
                            hintText: 'P@s*w0r&',
                            controller: _passwordController,
                            suffixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            obscureText: true,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                          ),
                          SizedBox(height: 24.0),
                          Row(
                            children: <Widget>[
                              RectangularButton(
                                buttonColor: Colors.purple[300],
                                textColor: Colors.white,
                                width: 147,
                                text: 'Sign In',
                                onPressed: isSignInButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                              ),
                              RectangularButton(
                                buttonColor: Colors.white,
                                width: 147,
                                textColor: Colors.purple[300],
                                text: 'Sign Up',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(
                                        userRepository: _userRepository,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signInBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signInBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.add(
      SignInWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
