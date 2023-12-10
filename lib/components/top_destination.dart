import 'package:flutter/material.dart';
import 'package:nepal_wanderer/components/top_card.dart';

import '../models/destination.dart';

class TopDestination extends StatelessWidget {
  const TopDestination({super.key});

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = [
      Destination('nagarkot', 'Nagarkot', '7999', 'Nepal','4.5'),
      Destination('okhaldhunga', 'Okhaldhunga', '8999', 'Nepal','4.5'),
      Destination('lumbini', 'Lumbini', '9999', 'Nepal','4.5'),
    ];
    return SizedBox(
      height: 95,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: destinations.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var dest = destinations[index];
          return CardTopDestination(
            image: dest.image,
            name: dest.name,
            location: dest.location,
          );
        },
      ),
    );
  }
}
