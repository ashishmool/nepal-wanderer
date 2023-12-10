import 'package:flutter/material.dart';

import '../utils/styles.dart';

class SearchDestination extends StatelessWidget {
  const SearchDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: accent,
            style: p1,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, size: 22, color: text),
              hintText: 'Search Destination',
              hintStyle: p1,
              fillColor: white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: small),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: small),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(50),
          ),
          height: 50,
          width: 50,
          child: Icon(Icons.swap_horiz, color: white),
        )
      ],
    );
  }
}