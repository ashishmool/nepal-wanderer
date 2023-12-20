import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:nepal_wanderer/pages/registration_screen.dart';
import 'homepage_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visibility = true;
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[900],
        title: Text(
          'Secure Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 160,
                child: Image.asset("assets/icons/nw-logo.png"),
                margin: EdgeInsets.all(40),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: visibility,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    child: visibility
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.black, wordSpacing: 2),
                      children: [
                        TextSpan(
                          text: 'Register Now',
                          style: TextStyle(fontSize: 16, color: Colors.red[800]),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RegistrationScreen.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  icon: Icon(Icons.dashboard, size: 50, color: Colors.blue[900]),
                  onPressed: () {
                    Navigator.pushNamed(context, HomepageScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
