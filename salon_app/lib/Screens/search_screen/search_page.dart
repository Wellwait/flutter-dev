import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salon_app/utils/colors.dart';

import '../../widget/custom_textfield.dart';
import '../Filter/filter_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [];
  final List<String> _popularSearches = [
    'Flutter',
    'Dart',
    'React',
    'Node.js',
    'JavaScript',
    'Python',
    'Go',
    'Kotlin',
  ];

  void _addSearch() {
    String searchQuery = _searchController.text.trim();
    if (searchQuery.isNotEmpty && !_recentSearches.contains(searchQuery)) {
      setState(() {
        // Limit to a maximum of 4 recent searches
        if (_recentSearches.length >= 4) {
          _recentSearches.removeLast(); // Remove the oldest search
        }
        _recentSearches.insert(0, searchQuery); // Add the new search
        _searchController.clear();
      });
    }
  }

  void _clearAll() {
    setState(() {
      _recentSearches.clear();
    });
  }

  void _removeSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: fabricColor,),
        ),
        title: const Center(
          child: Text(
              'Search',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FilterScreen());

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const FilterScreen()),
                // );
              },
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                width: 18,
                height: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: CustomTextField(
                controller: _searchController,
                hintText: 'Search salon or service..',
                hintTextColor: const Color(0xffADB3BC),
                textFieldColor: const Color(0xffD5ECEC),
                borderRadius: 25,
                prefixIcon: Icons.search,
                borderColor: Colors.transparent,
                iconColor: fabricColor,
              ),

            ),
            // TextField(
            //   controller: _searchController,
            //   decoration: InputDecoration(
            //     hintText: 'Search...',
            //     suffixIcon: IconButton(
            //       icon: Icon(Icons.search),
            //       onPressed: _addSearch,
            //     ),
            //   ),
            //   onSubmitted: (value) => _addSearch(),
            // ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Recent",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Outfit',
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _clearAll,
                  child: const Text(
                    "Clear All",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Outfit',
                      fontSize: 15,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // Recent Searches List
                  ..._recentSearches.map((search) => ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            search,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Ouutfit',
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis, // Handles overflow
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear,color: Colors.grey,size: 20,),
                          onPressed: () => _removeSearch(search),
                        ),
                      ],
                    ),
                    // Optional: Adding a Divider
                    subtitle: Divider(),
                  )).toList(),
                  const SizedBox(height: 16),
                  const Text('Popular Searches', style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Outfit',fontSize: 18)),
                  const SizedBox(height: 8),
                  // Wrap for Popular Searches
                  Wrap(
                    spacing: 8.0, // Space between items
                    runSpacing: 8.0, // Space between rows
                    children: _popularSearches.map((popular) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffE6F4F4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                          child: Text(
                              popular,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Outfit',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Chip(
label: Text(popular),
backgroundColor: Colors.blue[100],
);*/
