import 'package:flutter/material.dart';

class SearchTopSection extends StatelessWidget {
  const SearchTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Simulated AppBar with back button, title, and filter icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              const Expanded(
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Search bar with specified size (361x48)
        Center(
          child: Container(
            width: 361, // Width set to 361
            height: 48, // Height set to 48
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(24.0), // Fully rounded
            ),
            child: const Row(
              children: [
                SizedBox(width: 8),
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search salon or service..',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Recents section with lines between items
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recents',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Clear all',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _recentSearchItem('Blow-dry'),
              Divider(color: Colors.grey[300]), // Divider between items
              _recentSearchItem('Nail'),
              Divider(color: Colors.grey[300]), // Divider between items
              _recentSearchItem('Wax'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Popular Search',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _searchTag('Hair'),
              _searchTag('Nails'),
              _searchTag('Coloring'),
              _searchTag('Message'),
              _searchTag('Facials'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recentSearchItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 18, // Increased text size
              fontWeight: FontWeight.w500, // Slightly bolder
            ),
          ),
          const Icon(Icons.close, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _searchTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: const Color(0xFFF1F4F8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
