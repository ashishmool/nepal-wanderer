import 'package:flutter/material.dart';
import 'package:nepal_wanderer/components/recommended_destination.dart';
import 'package:nepal_wanderer/components/top_destination.dart';
import 'package:nepal_wanderer/pages/information_screen.dart';
import 'package:nepal_wanderer/pages/login_screen.dart';
import 'package:nepal_wanderer/pages/profile_screen.dart';
import '../components/header_top.dart';
import '../components/search_destination.dart';
import '../components/title_section.dart';
import '../utils/styles.dart';



class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  static const String routeName = "/homepage";

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: medium, top: 50, right: medium),
            child: Column(
              children: [
                const HeadingComponent(),
                SizedBox(height: medium),
                const SearchDestination(),
                SizedBox(height: medium),
                TitleSection(text: 'Most Popular', style: heading1),
                SizedBox(height: medium),
                const RecommendedDestination(),
                SizedBox(height: medium),
                SizedBox(height: medium),
                TitleSection(text: 'Top Destinations', style: heading2),
                const TopDestination(),
                SizedBox(height: medium),
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
        Navigator.pushNamed(context, ProfileScreen.routeName);
        break;
    }
  }
}
