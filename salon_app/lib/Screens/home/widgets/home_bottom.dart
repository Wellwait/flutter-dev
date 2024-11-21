import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/utils/colors.dart';

import '../../../dummydata.dart';
import '../../../widget/custom_button.dart'; // Import for SVG

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Most Search Interest Section
              const SizedBox(height: 16),
              const Text(
                'Most Search Interest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    itemsContainer('assets/icons/haircut.svg','Haircut'),
                    const SizedBox(width: 12),
                    itemsContainer('assets/icons/faicial.svg','Facial'),
                    const SizedBox(width: 12),
                    itemsContainer('assets/icons/nails.svg','Nails'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Cards Section
        SalonCard(
          imagePath: dummyimage,
          title: 'Beauty Salon',
          address: 'XYZ Address',
          rating: '4.7 (2.3k ratings)',
        ),
        SalonCard(
          imagePath: dummyimage,
          title: 'Beauty Salon',
          address: 'XYZ Address',
          rating: '4.7 (2.3k ratings)',
        ),
      ],
    );
  }

  itemsContainer(String imagePath,String text) {
    return Container(
      height: 50,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffEDF6F6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(imagePath),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SearchInterestItem extends StatelessWidget {
  final Widget icon; // Changed IconData to Widget
  final String label;

  const SearchInterestItem(
      {super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon, // Displaying the passed widget
        Text(label),
      ],
    );
  }
}

class SalonCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String address;
  final String rating;

  const SalonCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.address,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 10),
            child: Image.network(
              imagePath,
              height: 100,
            ),
          ), // Replace with actual image
          Expanded(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 16.0),
                          Text(rating),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffE6F4F4)
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            // Handle favorite action
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: CustomButtonWidget(
                          text: 'Book',
                          onPressed: () {},
                          borderRadius: 5,
                          buttonColor: fabricColor,
                          buttonHeight: 40,
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Handle book action
                      //   },
                      //   child: const Text('Book'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
