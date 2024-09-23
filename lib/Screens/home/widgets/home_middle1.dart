import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMiddle1 extends StatelessWidget {
  const HomeMiddle1({super.key});

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
              _buildCategoryButton('Women', true),
              _buildCategoryButton('Men', false),
              _buildCategoryButton('Kids', false),
            ],
          ),
        ),
        const SizedBox(height: 16),
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

  Widget _buildCategoryButton(String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Text(text),
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
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
