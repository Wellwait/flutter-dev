import 'package:flutter/material.dart';
import 'package:wellwait/Screens/booking2/widget/booking_screen2_bottom';
import 'package:wellwait/Screens/booking2/widget/booking_screen2_top.dart';

class BookingScreen2 extends StatelessWidget {
  const BookingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookingScreen2Top(),
            BookingScreen2Bottom(),
          ],
        ),
      ),
    );
  }
}
