import 'package:flutter/material.dart';
import 'package:wellwait/dummydata.dart'; // Ensure this import is correct

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
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250, // Set the height explicitly to avoid RenderFlex errors
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2, // Number of items in the list
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: 200, // Set the width of each card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            dummyimage, // Replace with your image asset path
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 150,
                          ),
                          const Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Plush Beauty Lounge',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        '2607 Haymond Rocks',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4.0),
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
                            style: TextStyle(color: Colors.grey),
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
