import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepal_wanderer/pages/homepage_screen.dart';
import 'package:nepal_wanderer/pages/login_screen.dart';

import '../utils/styles.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  static const String routeName = "/information";

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  int _currentIndex = 2;

  final List<PhoneNumber> importantNumbers = [
    PhoneNumber('Police (Emergency)', '100'),
    PhoneNumber('Tourist Police (Bhrikuti Mandap)', '01 4226359/4226403'),
    PhoneNumber('Nepal Tourism Board', '01 4256909/4256229'),
    PhoneNumber('Department of Immigration', '01 4223509/4222453'),
    PhoneNumber('Ambulance, Bishal Bazaar', '01 4244121'),
    PhoneNumber('Ambulance Nepal Chamber', '01 4230213/4222890'),
    PhoneNumber('Ambulance, Paropakar', '01 4251614/4260869'),
    PhoneNumber('Ambulance, Red Cross', '01 4228094'),
    PhoneNumber('Ambulance, Bhagawan Mahavir Jain Niketan', '01 4418619/4422280'),
    PhoneNumber('Bir Hospital', '01 4226963'),
    PhoneNumber('Patan Hospital (Lagankhel)', '01 5522278/5522266'),
    PhoneNumber('Teaching Hospital (Maharajgunj)', '01 4412707/4412505/4412808'),
    PhoneNumber('B & B Hospital (Gwarko)', '01 4351930/4533206'),
    PhoneNumber('Teku Hospital (Teku)', '01 4253396'),
    PhoneNumber('AWON Kalimati Clinic (Kalimati)', '01 4271873'),
    PhoneNumber('Blood Bank', '01 4225344'),
    PhoneNumber('CIWEC Clinic Durbar Mark', '01 4228531'),
    PhoneNumber('Homeopathic Clinic (Kalimati)', '01 4277431'),
    PhoneNumber('Kunfen Tibetan Medical Center (Chhetrapati)', '01 4251920'),
    PhoneNumber('Himalayan International Clinic (Chhetrapati)', '01 4263170'),
    PhoneNumber('Nepal International Clinic (Lal Durbar)', '01 4434642/4435357'),
    PhoneNumber('Himalayan Rescue Association (Tridevi Marg)', '01 4262746'),
    PhoneNumber('Synergy International Clinic (Thamel)', '01 4225038'),
    PhoneNumber('Tilganga Eye Centre', '01 4476575/4474937'),
    PhoneNumber('Homeopathic Treatment Centre', '01 4522092'),
    PhoneNumber('Friends of Shanta Bhawan', '01 4470181'),
    PhoneNumber('Nepal Oral Health Clinic', '01 4245572'),
    PhoneNumber('Ask me', '01 4427806'),
    PhoneNumber('Night Taxi', '01 4224374, 4224375'),
    PhoneNumber('Tribhuvan International Airport (TIA)', '01 4472256/4472257'),
    PhoneNumber('Himalayan Buddhist Meditation Centre', '01 4221875'),
    PhoneNumber('KEEP (Kathmandu Environmental Education Project)', '01 4259275'),
    PhoneNumber('AT&T Card Access', '01 0800-77001'),
    PhoneNumber('Asking Number', '197'),
    PhoneNumber('Annapurna Conservation Project (ACAP)', '01 4222406'),
  ];

  List<PhoneNumber> filteredNumbers = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredNumbers with all numbers when the screen is loaded
    filteredNumbers = List.from(importantNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: medium),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SearchNumber(onSearch: _onSearch),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                return filteredNumbers.isEmpty
                    ? Center(
                  child: Text('No matching numbers.'),
                )
                    : ListView.builder(
                  itemCount: filteredNumbers.length,
                  itemBuilder: (context, index) {
                    return ImportantNumberCard(
                      phoneNumber: filteredNumbers[index],
                      onCopy: () {
                        _copyToClipboard(
                            context, filteredNumbers[index].fullNumber);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
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
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: ''),
          ],
        ),
      ),
    );
  }

  void _onSearch(String query) {
    setState(() {
      filteredNumbers = importantNumbers
          .where((number) =>
          number.organization.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard: $text'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomepageScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, HomepageScreen.routeName);
        break;
      case 2:
      // Already on InformationScreen
        break;
      case 3:
        Navigator.pushNamed(context, LoginScreen.routeName);
        break;
    }
  }
}

class PhoneNumber {
  final String organization;
  final String phoneNumber;

  PhoneNumber(this.organization, this.phoneNumber);

  String get fullNumber => '$phoneNumber';
}

class ImportantNumberCard extends StatelessWidget {
  final PhoneNumber phoneNumber;
  final VoidCallback onCopy;

  const ImportantNumberCard({
    Key? key,
    required this.phoneNumber,
    required this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(phoneNumber.organization),
        subtitle: Text(phoneNumber.phoneNumber),
        trailing: IconButton(
          icon: Icon(Icons.content_copy),
          onPressed: onCopy,
        ),
      ),
    );
  }
}

class SearchNumber extends StatelessWidget {
  final Function(String) onSearch;

  const SearchNumber({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: InformationScreen()));
}
