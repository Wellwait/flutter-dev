import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/utils/colors.dart';

class HomeMiddle1 extends StatefulWidget {
  const HomeMiddle1({super.key});

  @override
  State<HomeMiddle1> createState() => _HomeMiddle1State();
}

class _HomeMiddle1State extends State<HomeMiddle1> {
  String selectedServiceFor = 'Women';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'What do you want to do?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryButton('Women'),
              _buildCategoryButton('Men'),
              _buildCategoryButton('Kids'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildServiceIcon(
                  'Haircut', SvgPicture.asset('assets/icons/haircut.svg')),
              _buildServiceIcon(
                  'Nails', SvgPicture.asset('assets/icons/nails.svg')),
              _buildServiceIcon(
                  'Facial', SvgPicture.asset('assets/icons/faicial.svg')),
              _buildServiceIcon(
                  'Coloring', SvgPicture.asset('assets/icons/coloring.svg')),
              _buildServiceIcon(
                  'Spa', SvgPicture.asset('assets/icons/spa.svg')),
              _buildServiceIcon(
                  'Waxing', SvgPicture.asset('assets/icons/wax.svg')),
              _buildServiceIcon(
                  'Makeup', SvgPicture.asset('assets/icons/makeup.svg')),
              _buildServiceIcon(
                  'Massage', SvgPicture.asset('assets/icons/massage.svg')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String serviceFor) {
    bool isSelected = selectedServiceFor == serviceFor;
    return SizedBox(
      width: 100,
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedServiceFor = serviceFor;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.teal : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.teal,
          side: const BorderSide(color: Colors.teal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          serviceFor,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(String label, Widget icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.teal[50],
          child: icon,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: fabricColor,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
