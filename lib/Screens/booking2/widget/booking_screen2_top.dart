import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingScreen2Top extends StatelessWidget {
  const BookingScreen2Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container Image at the top
          SizedBox(height: 50),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/container.png', // Path to your container image
              height: 150, // Adjust height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),

          // Beauty Salon Title and Rating in the same line
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Beauty Salon",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "XYZ Address\n45 min away, 1.5 km",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              // Rating Column
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                    size: 24,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "4.7",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "(2.3k ratings)",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),

          // Section Title
          Text(
            "Your Services Booking",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),

          // Service Booking Card
          Row(
            children: [
              // Service Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/icons/manicure.png', // Path to your local image
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              // Service Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Remove the text "Manicure"
                    Text(
                      "\$50 • Nail service",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Remove Icon
              IconButton(
                onPressed: () {
                  // Add your remove action here
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Add more section
          GestureDetector(
            onTap: () {
              // Add your add more action here
            },
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  "Add more",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Services List with SVGs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Haircut
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/haircut.svg',
                    height: 40,
                    width: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Haircut",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              // Nails
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/nails.svg',
                    height: 40,
                    width: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Nails",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              // Facial
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/faicial.svg',
                    height: 40,
                    width: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Facial",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              // Massage
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/massage.svg',
                    height: 40,
                    width: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Massage",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
