import 'package:flutter/material.dart';
import 'package:wellwait/Screens/home/widgets/home_bottom.dart';
import 'package:wellwait/Screens/home/widgets/home_middle1.dart';
import 'package:wellwait/Screens/home/widgets/home_middle2.dart';
import 'package:wellwait/Screens/home/widgets/home_top.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeTop(),
            HomeMiddle1(),
            HomeMiddle2(),
            HomeBottom(),
          ],
        ),
      ),
    );
  }
}
