import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/schedule/schedule_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import 'package:salon_app/utils/app_text_style.dart';
import 'package:salon_app/utils/app_strings.dart';
import '../widget/custom_button.dart';

class ScheduleScreenPage extends StatefulWidget {
  const ScheduleScreenPage({super.key});

  @override
  State<ScheduleScreenPage> createState() => _ScheduleScreenPageState();
}

class _ScheduleScreenPageState extends State<ScheduleScreenPage> {
  late ScheduleViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ScheduleViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              AppString.newText,
              style: AppTextStyle.getTextStyle18FontWeightBold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainCard(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _viewModel.cardData.length,
              itemBuilder: (context, index) {
                final card = _viewModel.cardData[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(card['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '${card['service']} ',
                                    style: AppTextStyle.getTextStyle15FontWeightw600,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' .${card['status']}',
                                        style: AppTextStyle.getTextStyleFontWeightw600,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  card['description'],
                                  style: AppTextStyle.getTextStyle13FontWeightw500,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  card['salonName'],
                                  style: AppTextStyle.getTextStyle18FontWeightBold,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  card['address'],
                                  style: AppTextStyle.getTextStyle14FontWeightw600Grey,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.yellowAccent),
                                    const SizedBox(width: 8),
                                    Text(
                                      card['rating'],
                                      style: AppTextStyle.getTextStyle14FontWeightw500Indigo,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.navigation_sharp, color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: CustomButtonWidget(
                                        text: AppString.rateUs,
                                        textColor: Colors.grey,
                                        onPressed: () {},
                                        buttonHeight: 40,
                                        buttonColor: Colors.white,
                                        borderRadius: 5,
                                        borderColor: Colors.grey,
                                        borderWidth: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  mainCard() {
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/icons/gallery1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.beautySalon,
                  style: AppTextStyle.getTextStyle20FontWeightBold,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellowAccent),
                    const SizedBox(width: 8),
                    Text(
                      AppString.ratings,
                      style: AppTextStyle.getTextStyle13FontWeightw500,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              AppString.address,
              style: AppTextStyle.getTextStyle13FontWeightw500,
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: AppString.service,
                style: AppTextStyle.getTextStyle15FontWeightw600,
                children: <TextSpan>[
                  TextSpan(
                    text: AppString.manicure,
                    style: AppTextStyle.getTextStyleFontWeightw600B,
                  ),
                  TextSpan(
                    text: AppString.booked,
                    style: AppTextStyle.getTextStyle13FontWeightw300,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppString.panelQueue,
              style: AppTextStyle.getTextStyle14FontWeightw300Teal,
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: fabricColor,
                  ),
                  child: const Center(
                    child: Icon(Icons.navigation_sharp, color: Colors.white),
                  ),
                ),
                CustomButtonWidget(
                  text: AppString.cancel,
                  textColor: Colors.grey,
                  onPressed: () {},
                  buttonHeight: 45,
                  buttonColor: Colors.white,
                  borderRadius: 5,
                  borderColor: Colors.grey,
                  borderWidth: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
