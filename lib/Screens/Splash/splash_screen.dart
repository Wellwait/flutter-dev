import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const SplashScreenApp());
}

class SplashScreenApp extends StatelessWidget {
  const SplashScreenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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

  void _startSequence() async {
    await _showElement(1); // Show Small Star
    await _hideElement();
    await _showElement(2); // Show Large Star
    await _hideElement();
    await _showElement(3); // Show Small Star Again
    await _hideElement();
    await _showElement(4); // Show WellWait Text with Star
    await _hideElement();
    await _showElement(5); // Show "Smooth your wait, ease your time"
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
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Well',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 33.0,
              fontWeight: FontWeight.w700,
              height: 1.3, // Equivalent to 42.9px line height
              letterSpacing: 0.04,
            ),
          ),
          TextSpan(
            text: 'Wait',
            style: const TextStyle(
              color: Colors.teal,
              fontFamily: 'Roboto',
              fontSize: 33.0,
              fontWeight: FontWeight.w700,
              height: 1.3, // Equivalent to 42.9px line height
              letterSpacing: 0.04,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmoothText() {
    return Text(
      '"Smooth your wait,\nease your time"',
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontSize: 33.0,
        fontWeight: FontWeight.w700,
        height: 1.3, // Equivalent to 42.9px line height
        letterSpacing: 0.04,
      ),
      textAlign: TextAlign.center,
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
              } else if (_currentStage == 5) {
                return _buildSmoothText();
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
