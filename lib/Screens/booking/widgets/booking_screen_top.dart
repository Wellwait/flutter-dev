import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingScreenTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color
      child: Column(
        children: [
          // Top image and icons row
          Stack(
            children: [
              Container(
                height: 200, // Adjust height of the image
                child: Image.network(
                  'https://img.freepik.com/free-vector/beauty-salon-concept-illustration_114360-6552.jpg?t=st=1727104485~exp=1727108085~hmac=00652078d4a500a35cce225a35d426a55646e8793964fcd3855b33ed1a4744c8&w=900', // Path to your SVG image
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.teal),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 30,
                right: 16,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.teal),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.arrow_upward, color: Colors.teal),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Business Information
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Beauty Salon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'xyz address',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '[Open Today]',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.local_offer, color: Colors.teal, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '-58%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.5 (2.7k)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.visibility, color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '8k views',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey[300], thickness: 1),

          // Opening Hours
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Opening Hours',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, color: Colors.teal, size: 10),
                        SizedBox(width: 4),
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Text(
                      '10:00am - 07:00pm',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, color: Colors.teal, size: 10),
                        SizedBox(width: 4),
                        Text(
                          'Lunch Time',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Text(
                      '01:00pm - 02:00pm',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
