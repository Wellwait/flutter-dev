import 'package:flutter/material.dart';
import 'package:salon_app/Screens/home/widgets/home_bottom.dart';
import 'package:salon_app/Screens/home/widgets/home_middle1.dart';
import 'package:salon_app/Screens/home/widgets/home_middle2.dart';
import 'package:salon_app/Screens/home/widgets/home_top.dart';
import 'package:salon_app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Function to handle bottom bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HomeTop(),
            HomeMiddle1(),
            HomeMiddle2(),
            HomeBottom(),
          ],
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Schedule',
          ),
        ],
        currentIndex: _selectedIndex, // Currently selected index
        selectedItemColor: fabricColor, // Color for the selected item
        onTap: _onItemTapped, // Handle tap event
      ),
    );
  }
}
