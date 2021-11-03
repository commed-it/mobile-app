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
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  appBarColor,
                  Colors.lightGreen,
                ],
              ),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10.0),
                child: Stack(children: [
                  BackButton(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Register',
                                style: TextStyle(
                                    fontSize: 50.0, color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'Lets get',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'you on board',
                                  style: TextStyle(
                                      fontSize: 30.0, color: Colors.white),
                                )),
                          ],
                        ),
                        const SizedBox(height: 20.0),
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
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white)),
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
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: Colors.white)),
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
                                  errorText:
                                      _wrongPassword ? _passwordText : null,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Respond to button press
                                  },
                                  child: Text("SIGN UP"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    // Respond to button press
                                  },
                                  child: Text(
                                    "I HAVE ALREADY AN ACCOUNT",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ]),
          )),
    );
  }
}
