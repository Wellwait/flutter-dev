import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG
import 'package:wellwait/dummydata.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Most Search Interest Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SearchInterestItem(
                    icon: SvgPicture.asset('assets/icons/haircut.svg'),
                    label: 'Haircut',
                  ),
                  SearchInterestItem(
                    icon: SvgPicture.asset('assets/icons/faicial.svg'),
                    label: 'Facial',
                  ),
                  SearchInterestItem(
                    icon: SvgPicture.asset('assets/icons/nails.svg'),
                    label: 'Nails',
                  ),
                ],
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imagePath,
            height: 100,
          ), // Replace with actual image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // Handle favorite action
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle book action
                        },
                        child: const Text('Book'),
                      ),
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
