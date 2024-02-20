import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:nepal_wanderer/pages/registration_screen.dart';
import 'package:nepal_wanderer/provider/user_view_model.dart';
import 'package:nepal_wanderer/services/notification_service.dart';
import 'package:provider/provider.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[900],
        title: Text(
          'Secure Login',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
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
                child:
                    Consumer<UserViewModel>(builder: (context, users, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      await users
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        print(users.user);
                        if (users.user.email != null) {
                          print("success");
                          emailController.clear();
                          passwordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Successful")));
                          Navigator.pushNamed(
                              context, HomepageScreen.routeName);
                        } else {
                          print(users.user.email);
                          print("failed");
                          emailController.clear();
                          passwordController.clear();
                        }
                      });

                      // if(emailController.text == null || passwordController.text == null){
                      //
                      // }
                      // else{
                      //   setState((){
                      //     loading = true;
                      //   });
                      //
                      //
                      //     final user = await _auth.signInWithEmailAndPassword(
                      //         email: emailController.text,
                      //         password: passwordController.text);
                      //     if (user.user != null) {
                      //
                      //       emailController.clear();
                      //       passwordController.clear();
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                      //       Navigator.pushNamed(context, HomepageScreen.routeName);
                      //     }
                      //
                      //   else{
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Mismatch")));
                      //   }
                    },
                    child: Text('Login',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black, wordSpacing: 2),
                      children: [
                        TextSpan(
                          text: 'Register Now',
                          style:
                              TextStyle(fontSize: 16, color: Colors.red[800]),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // SizedBox(
              //   width: double.infinity,
              //   child: IconButton(
              //     icon:
              //         Icon(Icons.dashboard, size: 50, color: Colors.blue[900]),
              //     onPressed: () {
              //       Navigator.pushNamed(context, HomepageScreen.routeName);
              //     },
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  icon:
                  Icon(Icons.notification_add, size: 50, color: Colors.blue[900]),
                  onPressed: () {
                    NotificationService.display(
                        title: "Holiday Notice",
                        body: "Happy New Year 2024. Holiday Information. Tomorrow is a holiday!",
                        image: "assets/icons/nw-logo.png");
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
