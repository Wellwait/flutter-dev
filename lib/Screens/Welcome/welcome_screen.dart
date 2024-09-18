import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                title: "Welcome to WellWait",
                subtitle: "Say goodbye to long waits at the salon!",
                width: 360,
                height: 164,
                top: 579,
                left: 16,
                gap: 0,
              ),
              _buildPage(
                title: "Find Salons Nearby",
                subtitle:
                    "Search and find the best salons around you with real-time wait times.",
                width: 360,
                height: 164,
                top: 579,
                left: 16,
                gap: 0,
              ),
              _buildPage(
                title: "Book Your Appointment",
                subtitle:
                    "Select your desired service, choose a time, and book your appointment hassle-free.",
                width: 360,
                height: 164,
                top: 579,
                left: 16,
                gap: 0,
              ),
              _buildPage(
                title: "Track Your Wait Time",
                subtitle:
                    "See real-time updates on your queue position and get notified when it's your turn.",
                width: 360,
                height: 164,
                top: 579,
                left: 16,
                gap: 0,
              ),
            ],
          ),
          // Bottom controls container
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              height: 41, // Set the height to 41 as per the image
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Add padding for left and right
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Implement skip logic here
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return _buildIndicator(index == _currentPage);
                    }),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.teal),
                    onPressed: () {
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Implement last page logic here, e.g., navigate to the main app screen
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    required double width,
    required double height,
    required double top,
    required double left,
    required double gap,
  }) {
    return Stack(
      children: [
        Positioned(
          top: top,
          left: left,
          child: Container(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.only(top: gap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.teal : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
