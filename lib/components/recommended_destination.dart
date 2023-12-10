import 'package:flutter/material.dart';
import 'package:nepal_wanderer/components/recommended_card.dart';

import '../models/destination.dart';

class RecommendedDestination extends StatelessWidget {
  const RecommendedDestination({super.key});

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = [
      Destination('pokhara-3', 'Trekking Paradise', '9999', 'Pokhara, Nepal','4.5'),
      Destination('bhaktapur-2', 'Explore Heritage', '5999', 'Bhaktapur, Nepal', '4.5'),
      Destination('pashupati-1', 'Valley Tour', '3999', 'Kathmandu, Nepal', '4.5'),
      Destination('annapurna-4', 'Annapurna Circuit', '39999', 'Ghandruk', '4.5'),
    ];
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: destinations.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dest = destinations[index];
          return CardRecommended(
            image: dest.image,
            name: dest.name,
            price: dest.price,
            location: dest.location,
            rating: dest.rating,
          );
        },
      ),
    );
  }
}
