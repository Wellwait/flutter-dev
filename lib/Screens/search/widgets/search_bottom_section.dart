import 'package:flutter/material.dart';

class SearchBottomSection extends StatelessWidget {
  final String dummyImage =
      'https://www.fezamutfak.com/pages/dekorasyon/evdekorasyonu/KremRenkliModernSalonDekorasyonu.jpg?w=&h=';

  const SearchBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Suggestion for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _suggestionCard(),
                const SizedBox(height: 16),
                _suggestionCard(),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _suggestionCard() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  dummyImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite, color: Colors.teal, size: 18),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    '1.1km',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hair · Facial',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sophisticated Salon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '360 Stillwater Rd. Palm City..',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _iconWithText(Icons.star, '4.7 (2.7k)', Colors.amber),
                    const SizedBox(width: 16),
                    _iconWithText(Icons.local_offer, '-58%', Colors.teal),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithText(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
