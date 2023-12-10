import 'package:flutter/material.dart';
import 'package:nepal_wanderer/pages/information_screen.dart';
import 'package:nepal_wanderer/pages/profile_screen.dart';

import 'homepage_screen.dart';

class BookingScreen extends StatelessWidget {
  static const String routeName = "/mybookings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: bookedTours.isEmpty
          ? Center(
        child: Text(
          'No Bookings To Show!',
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: bookedTours.length,
        itemBuilder: (context, index) {
          var tour = bookedTours[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(tour.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Date: ${tour.startDate}'),
                  Text('End Date: ${tour.endDate}'),
                  Text('Persons: ${tour.numberOfPersons}'),
                  Text('Amount Paid: ${tour.amountPaid}'),
                  Text('Invoice Number: ${tour.invoiceNumber}'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 94,
        child: BottomNavigationBar(
          currentIndex: 1, // Change the index based on your screen order
          onTap: (index) {
            _navigateToScreen(context, index);
          },
          iconSize: 29,
          selectedItemColor: Colors.green, // Change the color as needed
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
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

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomepageScreen.routeName);
        break;
      case 1:
      // BookingScreen
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

class BookedTour {
  final String name;
  final String startDate;
  final String endDate;
  final int numberOfPersons;
  final double amountPaid;
  final String invoiceNumber;

  BookedTour({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.numberOfPersons,
    required this.amountPaid,
    required this.invoiceNumber,
  });
}

List<BookedTour> bookedTours = [
  BookedTour(
    name: 'Pokhara Tour (2 Days)',
    startDate: '2023-01-01',
    endDate: '2023-01-07',
    numberOfPersons: 2,
    amountPaid: 14000.0,
    invoiceNumber: 'INV101',
  ),
  BookedTour(
    name: 'Everest Trekking (6 Days)',
    startDate: '2023-03-01',
    endDate: '2023-03-06',
    numberOfPersons: 1,
    amountPaid: 22000.0,
    invoiceNumber: 'INV102',
  ),
];
