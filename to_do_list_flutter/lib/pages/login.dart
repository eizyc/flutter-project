import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:to_do_list_flutter/common/style.dart';
import 'package:to_do_list_flutter/common/components/button.dart';
import 'package:to_do_list_flutter/common/components/input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // dark status bar
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/cover.png',
                        width: 187.0, height: 180.0, fit: BoxFit.contain),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyInput(
                        onChanged: (dynamic str) => setState(() {
                          email = str;
                        }),
                        placeholder: "Email",
                      ),
                      const SizedBox(height: 16.0),
                      MyInput(
                          onChanged: (dynamic str) => setState(() {
                                password = str;
                              }),
                          placeholder: "Password",
                          type: Type.password),
                      const SizedBox(height: 16.0),
                      Text("Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.primaryDarkValue.withOpacity(0.5))),
                      const SizedBox(height: 16.0),
                      MyButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home',
                                arguments: {});
                          },
                          text: "SIGN IN"),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.primaryDarkValue
                                      .withOpacity(0.4))),
                          const Text("Sign up",
                              style:
                                  TextStyle(color: Colors.primaryLightValue)),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
