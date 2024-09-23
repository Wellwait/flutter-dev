import 'package:flutter/material.dart';
import 'package:wellwait/Screens/booking/widgets/booking_screen_bottom.dart';
import 'package:wellwait/Screens/booking/widgets/booking_screen_middle2.dart';
import 'package:wellwait/Screens/booking/widgets/booking_screen_top.dart';
import 'package:wellwait/Screens/booking/widgets/booking_screen_middle1.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookingScreenTop(),
            BookingScreenMiddle1(),
            BookingScreenMiddle2(),
            BookingScreenBottom(),
          ],
        ),
      ),
    );
  }
}
