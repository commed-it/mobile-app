import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String name;
  late String email;
  late String password;

  static const String _emailText = 'Please use a valid email';
  static const String _passwordText = 'Please use a strong password';

  final bool _wrongEmail = false;
  final bool _wrongPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBarColor,
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Register',
                      style: TextStyle(fontSize: 50.0, color: Colors.white)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Lets get',
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      Text(
                        'you on board',
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          labelText: 'Full Name',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _wrongEmail ? _emailText : null,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: _wrongPassword ? _passwordText : null,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ))
        ]));
  }
}
