import 'package:flutter/material.dart';
import 'package:wellwait/Screens/search/widgets/search_top_section.dart';
import 'package:wellwait/Screens/search/widgets/search_bottom_section.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTopSection(),
          SearchBottomSection(),
        ],
      ),
    );
  }
}
