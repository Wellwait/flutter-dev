// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/past_booking/past_booking_viewmodel.dart';
import 'package:salon_app/queue/queue_page.dart';
import 'package:salon_app/queue/queue_viewmodel.dart';
import 'package:salon_app/rating/rating_page_viewmodel.dart';
import 'package:salon_app/schedule/schedule_viewmodel.dart';
import 'package:salon_app/settings/settings_viewmodel.dart';
import 'package:salon_app/utils/sp_helper.dart';
import 'package:salon_app/widget/bottom_bar_widget.dart';

import 'Screens/Filter/filter_screen.dart';
import 'Screens/Profile/profile_screen.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/auth/login_screen.dart';
import 'Screens/auth/verification_screen.dart';
import 'Screens/booking2/booking_screen2.dart';
import 'Screens/booking2/booking_screen2_viewmodel.dart';
import 'Screens/home/home_screen.dart';
import 'Screens/notification/notification_screen.dart';
import 'Screens/notification/notification_viewmodel.dart';
import 'Screens/payment/payment_screen.dart';
import 'Screens/payment/scan_screen.dart';
import 'Screens/registration/registration_viewmodel.dart';
import 'admin/admin_email_login/admin_email_login_page.dart';
import 'admin/admin_email_login/admin_email_login_viewmodel.dart';
import 'admin/admin_login/admin_login_page.dart';
import 'admin/admin_login/admin_login_viewmodel.dart';
import 'admin/admin_queue/admin_queue_page.dart';
import 'admin/admin_queue/admin_queue_viewmodel.dart';
import 'admin/admin_register/admin_register_viewmodel.dart';
import 'admin/otp_verification/otp_verification_viewmodel.dart';
import 'admin/salon_detail/solon_detail_viewmodel.dart';
import 'admin/salon_documents/salon_documents_viewmodel.dart';
import 'admin/salon_information/salon_information_viewmodel.dart';
import 'admin/salon_service/salon_service_viewmodel.dart';
import 'admin/salon_service/testing2.dart';
import 'admin/salon_service/testing_page.dart';
import 'admin/widget/top_nav_bar_widget.dart';
import 'booked/booked_screen.dart';
import 'booked/booked_screen_viewmodel.dart';
import 'booking_pending/booking_pending_viewmodel.dart';
import 'edit_profile/edit_profile.dart';
import 'edit_profile/edit_profile_viewmodel.dart';
import 'email_login/email_login_page.dart';
import 'email_login/email_login_viewmodel.dart';
import 'home_screen/home_screen_page.dart';
import 'home_screen/home_screen_viewmodel.dart';
import 'service_provider_details/sp_detail_viewmodel.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  // final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
  // String? email = await _sharedPreferenceService.getEmail();
  // int? status = await _sharedPreferenceService.getStatus();
  // print(status);

  //runApp(MyApp(initialPage:  AdminEmailLoginPage()));
  //initialPage: email != null ? BottomBar() : EmailLoginPage()
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
        ChangeNotifierProvider(create: (_) => BookedScreenViewModel()),
        ChangeNotifierProvider(create: (_) => RatingViewModel()),
        ChangeNotifierProvider(create: (_) => EmailLoginViewModel()),
        ChangeNotifierProvider(create: (_) => SPDetailViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => QueueViewModel()),
        ChangeNotifierProvider(create: (_) => AdminLoginViewModel()),
        ChangeNotifierProvider(create: (_) => OtpVerificationViewModel()),
        ChangeNotifierProvider(create: (_) => SolonDetailViewModel()),
        ChangeNotifierProvider(create: (_) => SalonInformationViewModel()),
        ChangeNotifierProvider(create: (_) => SalonServiceViewModel()),
        ChangeNotifierProvider(create: (_) => SalonDocumentsViewModel()),
        ChangeNotifierProvider(create: (_) => AdminEmailLoginViewModel()),
        ChangeNotifierProvider(create: (_) => AdminRegisterViewModel()),
        ChangeNotifierProvider(create: (_) => BookingScreen2ViewModel()),
        ChangeNotifierProvider(create: (_) => AdminQueueViewModel()),
        ChangeNotifierProvider(create: (_) => BookingPendingViewModel()),
        ChangeNotifierProvider(create: (_) => PastBookingVieModel()),

      ],
      child: MaterialApp(
        home: GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
          ),
          getPages: [
            GetPage(name: '/', page: () => SplashScreen()),
          ],
        ),
        //initialPage, // Use the determined initial page
      ),
    );
  }
}

// to start mysql
// sudo /usr/local/mysql/support-files/mysql.server start
// sudo /usr/local/mysql/support-files/mysql.server stop
// sudo /usr/local/mysql/support-files/mysql.server restart