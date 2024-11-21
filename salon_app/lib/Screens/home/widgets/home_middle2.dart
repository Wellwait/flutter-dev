import 'package:flutter/material.dart';
import 'package:salon_app/utils/colors.dart';

import '../../../dummydata.dart';

class HomeMiddle2 extends StatelessWidget {
  const HomeMiddle2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Rated Salon',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.grey,fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300, // Set the height explicitly to avoid RenderFlex errors
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2, // Number of items in the list
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: 200, // Set the width of each card
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity, // Full width
                            height: 180, // Height for the container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14), // Rounded corners
                              image: DecorationImage(
                                image: NetworkImage(
                                  dummyimage, // Replace with your image URL or asset
                                ),
                                fit: BoxFit.cover, // Cover the entire container with the image
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: fabricColor,
                              ),
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hair Facial 2+',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Plush Beauty Lounge',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: fabricColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        '2607 Haymond Rocks',
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '4.7 (2.7k)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
