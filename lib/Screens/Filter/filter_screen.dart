import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FilterScreen()));
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedService = 'Nails';
  int selectedRating = 4;
  String selectedServiceFor = 'All';
  RangeValues distanceRange = const RangeValues(0, 15);
  RangeValues priceRange = const RangeValues(500, 1500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            // Handle cancel action
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        title: const Text(
          'Filter',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Handle reset action
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Section
            Row(
              children: [
                const Text('Service', style: TextStyle(fontSize: 18)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle see all action
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Colors.teal, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildServiceButton('Nails'),
                const SizedBox(width: 10),
                _buildServiceButton('Haircut'),
                const SizedBox(width: 10),
                _buildServiceButton('Spa'),
              ],
            ),
            const SizedBox(height: 20),

            // Rating Section
            const Text('Rating', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildRatingStar(1),
                _buildRatingStar(2),
                _buildRatingStar(3),
                _buildRatingStar(4),
                _buildRatingStar(5),
                const SizedBox(width: 10),
                Text('$selectedRating Star'),
              ],
            ),
            const SizedBox(height: 20),

            // Service For Section
            const Text('Service for', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildServiceForButton('All'),
                const SizedBox(width: 10),
                _buildServiceForButton('Woman'),
                const SizedBox(width: 10),
                _buildServiceForButton('Men'),
                const SizedBox(width: 10),
                _buildServiceForButton('Kids'),
              ],
            ),
            const SizedBox(height: 20),

            // Distance Slider
            const Text('Distance', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            RangeSlider(
              values: distanceRange,
              min: 0,
              max: 15,
              divisions: 15,
              labels: RangeLabels(
                '${distanceRange.start.toInt()} km',
                '${distanceRange.end.toInt()} km',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  distanceRange = values;
                });
              },
              activeColor: Colors.teal,
              inactiveColor: Colors.grey,
            ),
            const SizedBox(height: 20),

            // Price Range Slider
            const Text('Price Range', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            RangeSlider(
              values: priceRange,
              min: 500,
              max: 1500,
              divisions: 10,
              labels: RangeLabels(
                '₹${priceRange.start.toInt()}',
                '₹${priceRange.end.toInt()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  priceRange = values;
                });
              },
              activeColor: Colors.teal,
              inactiveColor: Colors.grey,
            ),
            const Spacer(),

            // Show Result Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle show result action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Show Result',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceButton(String service) {
    bool isSelected = selectedService == service;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedService = service;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.teal,
        side: const BorderSide(color: Colors.teal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(service),
    );
  }

  Widget _buildRatingStar(int star) {
    return IconButton(
      icon: Icon(
        Icons.star,
        color: selectedRating >= star ? Colors.orange : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          selectedRating = star;
        });
      },
    );
  }

  Widget _buildServiceForButton(String serviceFor) {
    bool isSelected = selectedServiceFor == serviceFor;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedServiceFor = serviceFor;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.teal,
        side: const BorderSide(color: Colors.teal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(serviceFor),
    );
  }
}
