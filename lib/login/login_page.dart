import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';
import '../authentication/authentication.dart';
import './bloc/bloc.dart';
import './login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Icon(
                Icons.lock_outline,
                color: Color.fromRGBO(184, 56, 44, 1),
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
