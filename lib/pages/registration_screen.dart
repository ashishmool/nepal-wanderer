import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_wanderer/models/user_model.dart';
import 'package:provider/provider.dart';

import '../provider/user_view_model.dart';
import 'homepage_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String routeName = "/register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repassController = TextEditingController();
  bool visibility = true;
  bool loading = false;

  ImagePicker picker = ImagePicker();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore cloud = FirebaseFirestore.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  File? image;
  String? url;

  late UserViewModel userViewModel;

  @override
  void intState() {
    userViewModel = Provider.of(context, listen: false);
    super.initState();
  }

  void pickImage(ImageSource source) async {
    var selected = await picker.pickImage(source: source, imageQuality: 100);
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image selected")));
    } else {
      setState(() {
        image = File(selected.path);
        saveToStorage();
      });
    }
  }

  void saveToStorage() async {
    String name = image!.path.split('/').last;

    final photo = await storage
        .ref()
        .child('users')
        .child(name)
        .putFile(File(image!.path));
    String tempUrl = await photo.ref.getDownloadURL();
    setState(() {
      url = tempUrl;
    });
  }

  // FirebaseStorage storage = FirebaseStorage.instance;
  //

  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Create an Account',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Consumer<UserViewModel>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: 36),

                // Container(
                //   height: 120,
                //   width: 120,
                //   child: Stack(
                //     children: [
                //       CircleAvatar(
                //         backgroundImage: AssetImage("assets/images/profile.png"),
                //         radius: 60, // Adjust the radius as needed
                //       ),
                //       Positioned(
                //           bottom: 0,
                //           right: 8,
                //           child: Icon(
                //             Icons.camera_alt_outlined,
                //           ))
                //     ],
                //   ),
                // ),
                //
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Choose Location"),
                          content: Container(
                            height: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/cam-1.png"),
                                          radius:
                                              30, // Adjust the radius as needed
                                        ),
                                        Text("From Camera"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/gallery-1.png"),
                                          radius:
                                              30, // Adjust the radius as needed
                                        ),
                                        Text("From Gallery"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: image == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile.png"),
                            radius: 60, // Adjust the radius as needed
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 60, // Adjust the radius as needed
                          )),

                SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ), // Email
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
                ), //Password
                SizedBox(height: 16),
                TextFormField(
                  controller: repassController,
                  obscureText: visibility,
                  decoration: InputDecoration(
                    hintText: 'Re-enter Password',
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
                ), //Re-Password
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final data = UserModel(
                          email: emailController.text,
                          password: passwordController.text,
                          image: url);
                      await value
                          .save(data)
                          .then((value) {})
                          .onError((error, stackTrace) {});

                      // setState(() {
                      //   loading = true;
                      // });
                      //
                      // if (passwordController.text == repassController.text) {
                      //   final user = await _auth.createUserWithEmailAndPassword(
                      //       email: emailController.text,
                      //       password: passwordController.text);
                      //   if (user.user != null) {
                      //     emailController.clear();
                      //     passwordController.clear();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text("Registration Successful")));
                      //     Navigator.pushNamed(context, HomepageScreen.routeName);
                      //   }
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Password Mismatch")));
                      // }
                    },
                    child: Text('Create Account',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ), //Register Button
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful")));
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text('Back To Login',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: 100,
                //   child: Image.asset("assets/icons/nw-logo.png"),
                //   margin: EdgeInsets.all(10),
                //   padding: EdgeInsets.all(10),
                // ), //Logo
                // SizedBox(height: 16),//Back to Login Button
              ],
            ),
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegistrationScreen(),
  ));
}
