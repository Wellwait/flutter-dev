import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    Colors.grey[300], // Placeholder for profile image
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, XYZ',
                      style: GoogleFonts.manrope(
                        fontSize: 20, // Adjusted size to match
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Find the service you want, and treat yourself',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12, // Adjusted size to match
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                        color: const Color(0xFF50555C),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: fabricColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/BellBing.svg', // Original image path
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16), // Add some space before the search box
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: 361, // Width of the search box
              height: 45.97, // Height of the search box
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), // Shadow color with slight opacity
                    blurRadius: 5,
                    offset: const Offset(0, 2), // Offset of the shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Spacing between elements
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.search, color: Color(0xFF009688)),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        contentPadding: EdgeInsets.zero,
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0x87505050),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      'assets/icons/filter.svg', // Original image path
                      width: 17.5, // Width set to 17.5px
                      height: 11.5, // Height set to 11.5px
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: 361, // Width set to 361
            height: 159, // Height set to 159
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/icons/Shop.svg', // Original image path
                    fit: BoxFit.cover, // Fit image to cover the container
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Text(
                    'Look more beautiful\nand save more discount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/container.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
