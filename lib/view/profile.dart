import 'package:flutter/material.dart';
import 'package:memorize/view/authorize.dart';
import 'package:memorize/view/statistics.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); 
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: AuthorizePage()
            ),
            StatisticsPage(),
          ],
        ),
      )
    
    );
  }
}