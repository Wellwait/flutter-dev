// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:wellwait/Screens/Filter/filter_screen.dart';
import 'package:wellwait/Screens/Profile/profile_screen.dart';
import 'package:wellwait/Screens/Splash/splash_screen.dart';
import 'package:wellwait/Screens/Welcome/welcome_screen.dart';
import 'package:wellwait/Screens/auth/login_screen.dart';
import 'package:wellwait/Screens/auth/registration_screen.dart';
import 'package:wellwait/Screens/auth/verification_screen.dart';
import 'package:wellwait/Screens/booking/booking_screen.dart';
import 'package:wellwait/Screens/booking2/booking_screen2.dart';
import 'package:wellwait/Screens/home/home_screen.dart';
import 'package:wellwait/Screens/notification/notification_screen.dart';
import 'package:wellwait/Screens/payment/payment_completed.dart';
import 'package:wellwait/Screens/payment/scan_screen.dart';
import 'package:wellwait/Screens/search/search_screen.dart';
import 'package:wellwait/Screens/payment/payment_screen.dart';
import 'package:wellwait/Screens/booking/booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginScreen(),
      // home: RegistrationScreen(),
      // home: VerificationScreen(),
      // home: FilterScreen(),
      // home: ProfileScreen(),
      // home: SplashScreen(),
      // home: WelcomeScreen(),
      // home: NotificationScreen(),
      // home: PaymentScreen(),
      // home: ScanScreen(),
      // home: PaymentCompleted(),
      // home: SearchScreen(),
      // home: BookingScreen(),
      home: BookingScreen2(),
    );
  }
}
