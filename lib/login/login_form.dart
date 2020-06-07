import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import './bloc/bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _projectController = TextEditingController();
  bool _remembered = false;
  String _project = "One";
  Color fontColor = Color.fromRGBO(153, 153, 153, 1);
  Color buttonColor = Color.fromRGBO(184, 56, 44, 1);
  var fontSize = 14.0;
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
            id: _idController.text,
            password: _passwordController.text,
            project: _projectController.text),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          )),
                          labelText: 'Enter Id',
                          // contentPadding: const EdgeInsets.all(14.0),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          )),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          )),
                      controller: _idController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            )),
                            labelText: 'Enter Password',
                            // contentPadding: const EdgeInsets.all(14.0),
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            )),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromRGBO(153, 153, 153, 1),
                            )),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ),
                    OutlineDropdownButton(
                      inputDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          )),
                          prefixIcon: const Icon(
                            Icons.domain,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          )),
                      value: _project,
                      isDense: true,
                      style: TextStyle(color: fontColor, fontSize: fontSize),
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          _project = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () => setState(() {
                              _remembered = !_remembered;
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: _remembered
                                          ? Color.fromRGBO(184, 56, 44, 1)
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: fontColor)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Remeber Me',
                                    style: TextStyle(
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                        fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                          RaisedButton(
                            color: buttonColor,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'LOG IN',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'work-sans',
                                      fontWeight: FontWeight.normal),
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: state is LoginLoading
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
