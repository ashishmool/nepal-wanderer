import 'package:flutter/material.dart';
import 'package:nepal_wanderer/pages/homepage_screen.dart';

import '../utils/styles.dart';
import 'information_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController securityQuestionController = TextEditingController();
  TextEditingController securityAnswerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Sample user data. Replace this with the actual data from registration.
    final String fullName = "Ashish Mool";
    final String email = "asis.mool@gmail.com";
    final String securityQuestion = "What is your favorite color?";
    final String securityAnswer = "blue";

    // Initialize controllers with existing data
    fullNameController.text = fullName;
    emailController.text = email;
    securityQuestionController.text = securityQuestion;
    securityAnswerController.text = securityAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileInfo('Full Name:', fullNameController),
                buildProfileInfo('Email:', emailController),
                buildProfileInfo('Security Question:', securityQuestionController),
                buildProfileInfo('Security Answer:', securityAnswerController),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle saving changes here
                      // You can implement logic to update user information
                      // using the data from the controllers
                      // For simplicity, I'm just navigating back to the registration screen
                      Navigator.pop(context);
                    },
                    child: Text('Save Changes', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
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
      ),
      bottomNavigationBar: SizedBox(
        height: 94,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _navigateToScreen(index);
            });
          },
          iconSize: 29,
          selectedItemColor: accent,
          unselectedItemColor: icon,
          backgroundColor: white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.emergency_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: ''),
          ],
        ),
      ),
    );
  }
  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomepageScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, LoginScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, InformationScreen.routeName);
        break;
      case 3:
      // Already on ProfileScreen
        break;
    }
  }

  Widget buildProfileInfo(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
