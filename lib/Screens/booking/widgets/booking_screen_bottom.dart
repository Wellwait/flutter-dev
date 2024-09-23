import 'package:flutter/material.dart';

class BookingScreenBottom extends StatelessWidget {
  final List<String> galleryImages = [
    'assets/icons/gallery1.png',
    'assets/icons/gallery2.png',
    'assets/icons/gallery3.png',
    'assets/icons/gallery4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gallery Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gallery',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('View all', style: TextStyle(color: Colors.teal)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: galleryImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(galleryImages[index],
                      height: 80, width: 80, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),

        // Reviews Section
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('View all', style: TextStyle(color: Colors.teal)),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Review Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/icons/profile.png'), // Replace with your asset path
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Annie',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            Icon(Icons.star_border,
                                color: Colors.orange, size: 16),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text('2 days ago', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'The place was clean, great service, stall are friendly. I will certainly recommend to my friends and visit again! ;)',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
