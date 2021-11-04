import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_app/fade_animation.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal,
                Colors.deepPurpleAccent,
              ]),
        ),
        child: loginView(context),
      ),
    );
  }

  Column loginView(BuildContext context) {
    return Column(
      children: const [HeadLogin(), BodyLogin()],
    );
  }
}

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  bool register = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: register,
                    child: FadeAnimation(
                      0.2,
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: fieldBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.work_outline),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          label: Text(" " +
                                              AppLocalizations.of(context)!
                                                  .company_name),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: fieldBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.article_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          label: Text(" " +
                                              AppLocalizations.of(context)!
                                                  .nif),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          const Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 1.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2,
                    Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: fieldBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.account_circle),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    label: Text(" " +
                                        AppLocalizations.of(context)!.username),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  FadeAnimation(
                    2,
                    Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: fieldBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.password_outlined),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    label: Text(" " +
                                        AppLocalizations.of(context)!.password),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: this.register,
                    child: FadeAnimation(
                      0.5,
                      Column(children: [
                        Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: fieldBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.password_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        label: Text(" " +
                                            AppLocalizations.of(context)!
                                                .repeat_password),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          thickness: 1.0,
                        ),
                        Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: fieldBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.alternate_email),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        label: Text(" " +
                                            AppLocalizations.of(context)!
                                                .email),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: fieldBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.local_phone),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        label: Text(" " +
                                            AppLocalizations.of(context)!
                                                .contact),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !register,
                    child: FadeAnimation(
                      0.5,
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: Colors.teal.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: 110,
                                height: 45,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.login_verb,
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            OutlinedButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.teal,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              label: SizedBox(
                                width: 100,
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .register_switch,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  register = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: register,
                    child: FadeAnimation(
                      1,
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: Colors.teal.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: 110,
                                height: 45,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.register,
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            OutlinedButton.icon(
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: Colors.teal,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              label: SizedBox(
                                width: 170,
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .login_switch,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  register = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }
}

BoxDecoration fieldBoxDecoration() {
  return const BoxDecoration(boxShadow: [
    BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(1, 1)),
  ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)));
}

class HeadLogin extends StatelessWidget {
  const HeadLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 60, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: FadeAnimation(
                        1,
                        Column(
                          children: [
                            Image.asset(
                              'assets/logo-white.png',
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .login_noun
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontFamily: 'RobotMono'),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Column()
            ]),
      ),
    );
  }
}
