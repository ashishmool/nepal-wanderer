import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String routeName = "/register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repassController = TextEditingController();
  final TextEditingController securityQuestionController = TextEditingController();
  final TextEditingController securityAnswerController = TextEditingController();
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[900],
        title: Text(
          'Create an Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Image.asset("assets/icons/nw-logo.png"),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              SizedBox(height: 16),
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
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Create Account', style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
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
    home: RegistrationScreen(),
  ));
}
