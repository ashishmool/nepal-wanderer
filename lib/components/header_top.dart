import 'package:flutter/material.dart';
import 'package:nepal_wanderer/provider/user_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/styles.dart';

class HeadingComponent extends StatelessWidget {
  const HeadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context,users,child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: text,
                      borderRadius: BorderRadius.circular(100),
                      image:
                      users.user.image == null ?
                      DecorationImage(
                        image: AssetImage('assets/images/profile.png'),
                      ) :   DecorationImage(
                        image: NetworkImage(users.user.image.toString()),
                      )

                  ),
                  height: 50,
                  width: 50,
                ),
                SizedBox(width: small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome', style: p1),
                    Text('${users.user.email}', style: heading3),
                  ],
                ),
              ],
            ),
            Icon(Icons.notifications, color: icon, size: 28),
          ],
        );
      }
    );
  }
}