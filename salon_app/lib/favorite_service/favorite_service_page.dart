import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_screen/home_screen_viewmodel.dart';
import '../utils/app_text_style.dart';

class FavoriteServicesPage extends StatefulWidget {
  @override
  State<FavoriteServicesPage> createState() => _FavoriteServicesPageState();
}

class _FavoriteServicesPageState extends State<FavoriteServicesPage> {
  late HomeScreenViewModel _homeScreenViewModel;

  @override
  Widget build(BuildContext context) {
    _homeScreenViewModel = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),
        ),
        title: Center(
          child: Text(
            "Favorite",
            style: AppTextStyle.getTextStyle16FontWeightw600,
          ),
        ),
        centerTitle: true,
      ),
      body: _homeScreenViewModel.favoriteService.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.question_answer_outlined,
              color: Colors.teal,
              size: 80,
            ),
            const SizedBox(height: 12),
            Text(
              "No favorite services added yet",
              style: AppTextStyle.getTextStyle17FontWeightw600,
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _homeScreenViewModel.favoriteService.length,
        itemBuilder: (context, index) {
          final service = _homeScreenViewModel.favoriteService[index];
          return bottomCard(
            service.photo ?? "",
            service.salonName ?? "",
            service.address ?? "",
            service.averageRating
          );
        },
      ),
    );
  }

  Widget bottomCard(String imagePath,String name, String address, String rating) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.9),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   title,
                      //   style: AppTextStyle.getTextStyle13FontWeightw300,
                      // ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: AppTextStyle.getTextStyle18FontWeightBold,
                      ),
                      Text(
                        address,
                        style: AppTextStyle.getTextStyle14FontWeightw500,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ((double.parse(rating) * 10).round() / 10).toString(),
                            style: AppTextStyle.getTextStyle14FontWeightw500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
