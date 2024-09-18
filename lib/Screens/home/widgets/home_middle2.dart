import 'package:flutter/material.dart';
import 'package:wellwait/dummydata.dart'; // Ensure this import is correct

class HomeMiddle2 extends StatelessWidget {
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
              Text(
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
                child: Text(
                  'View all',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250, // Set the height explicitly to avoid RenderFlex errors
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2, // Number of items in the list
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
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
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Plush Beauty Lounge',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '2607 Haymond Rocks',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 4.0),
                      Row(
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
