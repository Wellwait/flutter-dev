import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../email_login/email_login_page.dart';
import '../../email_login/email_login_viewmodel.dart';
import '../../utils/common_variables.dart';
import '../../utils/sp_helper.dart';
import '../../widget/bottom_bar_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  int _currentStage = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _startSequence();
  }

  autoLoginUser() async {
    final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
    int? userId = await _sharedPreferenceService.getUserId();
    if (userId != null) {
      userName = await _sharedPreferenceService.getUsername() ?? '';
      userPhoneNumber = await _sharedPreferenceService.getUserPhoneNumber() ?? '';
      userEmail = await _sharedPreferenceService.getUserEmail() ?? '';
      userGender = await _sharedPreferenceService.getUserGender();
      final birthdayString = await _sharedPreferenceService.getUserBirthday();
      if (birthdayString != null && birthdayString.isNotEmpty) {
        try {
          userBirthday = DateTime.parse(birthdayString);
          print('Splash Birthday date : ${userBirthday}');
          print('Print Splash birthday date and birthdayString');
          print('Splash birthdayString : ${birthdayString}');
        } catch (e) {
          print("Error parsing birthday: $e");
          userBirthday = null;
        }
      }

      Provider.of<EmailLoginViewModel>(context, listen: false)
          .setUserId(userId);
      Get.to(() => BottomBar());
    } else {
      Get.to(() => EmailLoginPage());
    }
  }

  void _startSequence() async {
    await _showElement(1);
    await _hideElement();
    await _showElement(2);
    await _hideElement();
    await _showElement(3);
    await _hideElement();
    await _showElement(4);
    await autoLoginUser();
  }

  Future<void> _showElement(int stage) async {
    setState(() => _currentStage = stage);
    await _controller.forward(); // Fade in
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> _hideElement() async {
    await _controller.reverse(); // Fade out
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStar({required String assetName, double size = 20.0}) {
    return SvgPicture.asset(
      'assets/icons/$assetName',
      width: size,
      height: size,
    );
  }

  Widget _buildWellWaitText() {
    return RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Well',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 33.0,
              fontWeight: FontWeight.w700,
              height: 1.3,
              // Equivalent to 42.9px line height
              letterSpacing: 0.04,
            ),
          ),
          TextSpan(
            text: 'Wait',
            style: TextStyle(
              color: Colors.teal,
              fontFamily: 'Roboto',
              fontSize: 33.0,
              fontWeight: FontWeight.w700,
              height: 1.3,
              // Equivalent to 42.9px line height
              letterSpacing: 0.04,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Builder(
            builder: (context) {
              if (_currentStage == 1) {
                return _buildStar(
                    assetName: 'smallstar.svg', size: 20.0); // Small Star
              } else if (_currentStage == 2) {
                return _buildStar(
                    assetName: 'bigstar.svg', size: 40.0); // Large Star
              } else if (_currentStage == 3) {
                return _buildStar(
                    assetName: 'smallstar.svg', size: 20.0); // Small Star Again
              } else if (_currentStage == 4) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStar(assetName: 'smallstar.svg', size: 20.0),
                    const SizedBox(width: 8.0),
                    _buildWellWaitText(),
                  ],
                ); // Small Star + "WellWait" Text
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
