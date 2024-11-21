import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/utils/app_text_style.dart';
import 'package:salon_app/utils/common_variables.dart';

import '../Screens/Filter/filter_screen.dart';
import '../Screens/booking2/booking_screen2.dart';
import '../Screens/notification/notification_screen.dart';
import '../Screens/registration/registration_screen.dart';
import '../Screens/search_screen/search_page.dart';
import '../admin/admin_email_login/admin_email_login_viewmodel.dart';
import '../booking_pending/booking_pending_page.dart';
import '../dummydata.dart';
import '../edit_profile/edit_profile.dart';
import '../email_login/email_login_page.dart';
import '../email_login/email_login_viewmodel.dart';
import '../favorite_service/favorite_service_page.dart';
import '../models/categories.dart';
import '../models/favorite.dart';
import '../past_booking/past_booking_page.dart';
import '../service_provider_details/service_provider_detail_page.dart';
import '../settings/settings_page.dart';
import '../utils/app_strings.dart';
import '../utils/colors.dart';
import '../utils/sp_helper.dart';
import '../widget/custom_button.dart';
import 'home_screen_viewmodel.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch data methods
      _viewModel.fetchData();
      _viewModel.fetchServiceData();
      _viewModel.fetchSalonServiceProvidersData();
      _viewModel.fetchFavorite();
    });
  }


  late HomeScreenViewModel _viewModel;
  late AdminEmailLoginViewModel _adminEmailLoginViewModel;
  late EmailLoginViewModel _emailLoginViewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<HomeScreenViewModel>();
    _adminEmailLoginViewModel = Provider.of<AdminEmailLoginViewModel>(context, listen: false);
    _emailLoginViewModel = Provider.of<EmailLoginViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${userName.toString()}',
                    style: AppTextStyle.getTextStyle12FontWeightw700,
                  ),
                  Text(
                    'Find the service you want, and treat yourself',
                    style: AppTextStyle.getTextStyle12FontWeightw400,
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/icons/gallery2.png'),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: IconButton(
        //       icon: Container(
        //         width: 40,
        //         height: 40,
        //         decoration: const BoxDecoration(
        //           color: fabricColor,
        //           shape: BoxShape.circle,
        //         ),
        //         child: Center(
        //           child: SvgPicture.asset(
        //             'assets/icons/BellBing.svg',
        //             width: 24,
        //             height: 24,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       onPressed: () {
        //         Get.to(() => NotificationScreen());
        //
        //         // Navigator.push(
        //         //   context,
        //         //   MaterialPageRoute(builder: (context) => NotificationScreen()), // Navigate to the new page
        //         // );
        //       },
        //     ),
        //   ),
        // ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topScreenItems(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppString.whatDoYouWant,
                style: AppTextStyle.getTextStyle20FontWeightw600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton(AppString.women),
                  _buildCategoryButton(AppString.men),
                  _buildCategoryButton(AppString.kids),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildServiceList(_viewModel.subcategory[_viewModel.selectedServiceFor]!),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   AppString.topRatedSalon,
                    style: AppTextStyle.getTextStyle20FontWeightBold,
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: Text(
                      AppString.viewAll,
                      style: AppTextStyle.getTextStyle15FontWeight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 320,
              child: _viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _viewModel.serviceProvider.length,
                itemBuilder: (context, index) {
                  final salonService = _viewModel.serviceProvider[index];
                  //print('mobileNumber: ${mobileNumber}');
                  // Safely get the first image from promoImages if available
                  final List<String> promoImages = (salonService.promoImages ?? '')
                      .split(',')
                      .map((s) => s.trim())
                      .toList();
                  // Use the first promo image if available; otherwise, use a dummy image
                  final String salonServiceImage = (promoImages.isNotEmpty && promoImages[0].isNotEmpty)
                      ? promoImages[0]
                      : dummyimage; // Default image if promoImages is empty
                  // Use null-aware operators for accessing properties safely
                  final String serviceProviderName = salonService.salonName ?? 'Unknown Type';
                  final String salonServiceAddress = salonService.address ?? 'Unknown Location';
                  // Check if the service is already in favorites
                  bool isFavorite = favoriteList.contains(salonService.id);
                  // Display logic for service names
                  String displayServiceNames() {
                    final serviceNamesList = (salonService.serviceNames ?? '')
                        .split(',')
                        .map((s) => s.trim())
                        .toList();
                    if (serviceNamesList.isEmpty || (serviceNamesList.length == 1 && serviceNamesList[0].isEmpty)) {
                      return 'Unknown Service';
                    }
                    if (serviceNamesList.length <= 2) {
                      return serviceNamesList.join(', ');
                    }
                    return '${serviceNamesList.take(2).join(', ')} +${serviceNamesList.length - 2}';
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: () async {
                        serviceProviderId = salonService.id!;
                        await _viewModel.increaseViewCount(serviceProviderId);
                        mobileNumber = salonService.mobileNumber.toString();
                        print(salonService.mobileNumber);
                        print(salonService.id!);
                        // Navigate to the next page
                        Get.to(() => ServiceProviderDetailPage(
                          userName: serviceProviderName,
                          address: salonServiceAddress,
                          imagePath: salonServiceImage,
                          viewCount: salonService.viewCount!,
                          averageRating: salonService.averageRating!.toDouble(),
                          totalRatings: salonService.totalRatings!,
                        ));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ServiceProviderDetailPage(
                        //       userName: serviceProviderName,
                        //       address: salonServiceAddress,
                        //       imagePath: salonServiceImage,
                        //       viewCount: salonService.viewCount!,
                        //       averageRating: salonService.averageRating!.toDouble(),
                        //       totalRatings: salonService.totalRatings!,
                        //     ),
                        //   ),
                        // );
                      },
                      child: SizedBox(
                        width: 200,
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                // Ensure image is displayed with error handling
                                Container(
                                  width: double.infinity,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: salonServiceImage,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter:
                                            const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  )
                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFavorite) {
                                          // Remove from favorites
                                          _viewModel.favoriteService.removeWhere(
                                                  (service) => service.photo == salonServiceImage
                                          );
                                        } else {
                                          _viewModel.addFavorite(salonService.id);
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isFavorite ? Colors.transparent : fabricColor,
                                      ),
                                      child: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? fabricColor : Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayServiceNames(),
                                  style: AppTextStyle.getTextStyle12FontWeight,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),

                                const SizedBox(height: 6),
                                Text(
                                  serviceProviderName,
                                  style: AppTextStyle.getTextStyle17FontWeightw600,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  salonServiceAddress,
                                  style: AppTextStyle.getTextStyle17FontWeightw400,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${salonService.averageRating!.toDouble()} (${salonService.totalRatings}) Rating',
                                  style: AppTextStyle.getTextStyle15FontWeightw500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              ),
            ),
            // const SizedBox(height: 16),
            // Container(
            //   margin: const EdgeInsets.only(left: 15,right: 15),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         AppString.mostSearchInterest,
            //         style: AppTextStyle.getTextStyle20FontWeightw600B,
            //       ),
            //       const SizedBox(height: 20),
            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             itemsContainer('assets/icons/haircut.svg',AppString.haircut),
            //             const SizedBox(width: 12),
            //             itemsContainer('assets/icons/faicial.svg', AppString.facial),
            //             const SizedBox(width: 12),
            //             itemsContainer('assets/icons/nails.svg',AppString.nails),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 15,right: 15),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSlidingSegmentedControl<int>(
                      thumbColor: fabricColor,
                      backgroundColor: const Color(0xffE6F4F4),
                      children: {
                        0: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(child: Text(AppString.all,style: TextStyle(color: _viewModel.selectedSegment == 0 ? Colors.white : Colors.grey,fontWeight: FontWeight.w600, fontFamily: 'Outfit',),)),
                          ),
                        ),
                        1: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(child: Text(AppString.nearBy,style: TextStyle(color: _viewModel.selectedSegment == 1 ? Colors.white : Colors.grey,fontWeight: FontWeight.w600, fontFamily: 'Outfit',)))),
                        ),
                      },
                      groupValue: _viewModel.selectedSegment,
                      onValueChanged: (int? value) {
                        setState(() {
                          _viewModel.selectedSegment = value;
                        });
                      },
                    ),
                  ),
                  // const SizedBox(width: 30),
                  // Container(
                  //   height: 42,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: const Color(0xffE6F4F4),
                  //   ),
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Center(
                  //       child: Icon(Icons.menu,size: 20,color: Colors.teal,),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Conditional rendering of the red container
            if (_viewModel.selectedSegment == 0)
              _viewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height, // Constrain the height
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        _viewModel.serviceProvider.length, (index) {
                      //final service = _viewModel.services[index];
                      final salonService = _viewModel.serviceProvider[index];
                      final List<String> promoImages = (salonService.promoImages ?? '')
                          .split(',')
                          .map((s) => s.trim())
                          .toList();
                      // Use the first promo image if available; otherwise, use a dummy image
                      final String salonServiceImage = (promoImages.isNotEmpty && promoImages[0].isNotEmpty)
                          ? promoImages[0]
                          : dummyimage;

                      String displayServiceNames() {
                        final serviceNamesList = (salonService.serviceNames ?? '')
                            .split(',')
                            .map((s) => s.trim())
                            .toList();
                        if (serviceNamesList.isEmpty || (serviceNamesList.length == 1 && serviceNamesList[0].isEmpty)) {
                          return 'Unknown Service';
                        }
                        if (serviceNamesList.length <= 2) {
                          return serviceNamesList.join(', ');
                        }
                        return '${serviceNamesList.take(2).join(', ')} +${serviceNamesList.length - 2}';
                      }
                      return bottomCard(
                        salonService.id!,
                        salonServiceImage, // Fallback image
                        displayServiceNames() ?? 'Unknown Service',
                        salonService.salonName ?? 'Unknown Salon',
                        // service.rating?.toString() ?? 'No Rating',
                        salonService.address ?? 'Unknown Address',
                        // service.id!,
                        // service.viewCount!,
                        salonService.averageRating!.toDouble(),
                        salonService.totalRatings!,
                        _viewModel,
                        context,
                            () async {
                          // This is where you handle the navigation
                              //serviceProviderId = service.serviceProviderId!;
                              serviceProviderId = salonService.id!;
                          await _viewModel.increaseViewCount(serviceProviderId); // Use service.id instead
                              Get.to(() => ServiceProviderDetailPage(
                                userName: salonService.salonName ?? 'Unknown Salon',
                                address: salonService.address ?? 'Unknown Address',
                                imagePath: salonServiceImage ,
                                viewCount: salonService.viewCount!,
                                averageRating: salonService.averageRating!.toDouble(),
                                totalRatings: salonService.totalRatings,
                              ));

                          //     Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ServiceProviderDetailPage(
                          //       userName: salonService.salonName ?? 'Unknown Salon',
                          //       address: salonService.address ?? 'Unknown Address',
                          //       imagePath: salonServiceImage ,
                          //       viewCount: salonService.viewCount!,
                          //       averageRating: salonService.averageRating!.toDouble(),
                          //       totalRatings: salonService.totalRatings,
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    }),
                  ),
                ),
              )

          ],
        ),
      ),
    );
  }

  topScreenItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      onTap: () {
                        Get.to(() => SearchPage());
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppString.search,
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
                    child: GestureDetector(
                      onTap: () {
                        //Get.to(() => FilterScreen());
                      },
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg', // Original image path
                        width: 17.5, // Width set to 17.5px
                        height: 11.5, // Height set to 11.5px
                      ),
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
                Positioned(
                  left: 16,
                  top: 16,
                  child: Text(
                    AppString.lookMoreBeautiful,
                    style: AppTextStyle.getTextStyle18FontWeightw600,
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

  Widget _buildCategoryButton(String serviceFor) {
    bool isSelected = _viewModel.selectedServiceFor == serviceFor;
    return SizedBox(
      width: 100,
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _viewModel.updateCategory(serviceFor); // Update selected category
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.teal : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.teal,
          side: const BorderSide(color: Colors.teal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          serviceFor,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
          ),
        ),
      ),
    );
  }


  Widget _buildServiceList(List<Subcategories> services) {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Wrap(
      spacing: 35.0, // Horizontal spacing between items
      runSpacing: 30.0, // Vertical spacing between rows
      children: services.map((service) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE6F4F4),
              ),
              child: Center(
                child:SvgPicture.string(
                  service.icon!,
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(20.0),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4), // Space between icon and text
            Text(
              service.name ?? '',
              style: AppTextStyle.getTextStyle12FontWeightw600,
            ), // Display the service name
          ],
        );
      }).toList(),
    );
  }


  itemsContainer(String imagePath,String text) {
    return Container(
      height: 50,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffEDF6F6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(imagePath),
              const SizedBox(width: 15),
              Text(
                text,
                style: AppTextStyle.getTextStyle14FontWeightw300,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget bottomCard(
      int id,
      String imagePath,
      String title,
      String salonName,
      String address,
      double averageRating,
      int totalRating,
      HomeScreenViewModel viewModel,
      BuildContext context,
      VoidCallback onPressed,
      ) {
    // Check if the service is already favorited
    bool isFavorited = favoriteList.contains(id);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 145,
            margin: const EdgeInsets.all(8),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn),
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.isNotEmpty ? title : 'No Name',
                        style: AppTextStyle.getTextStyle12FontWeightw300,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        salonName.isNotEmpty ? salonName : 'No Title',
                        style: AppTextStyle.getTextStyle18FontWeightBold,
                      ),
                      Text(
                        address.isNotEmpty ? address : 'No Address',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16.0),
                          const SizedBox(width: 4),
                          Text(
                            '${averageRating} (${totalRating}) Rating',
                            style: AppTextStyle.getTextStyle14FontWeight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffE6F4F4),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isFavorited ? fabricColor : Colors.black,
                          ),
                          onPressed: () {
                            // // Toggle favorite status
                            // final isFavorited = viewModel.favoriteService.any((service) => service.salonName == salonName);

                            if (isFavorited) {
                              // Remove from favorites
                             // viewModel.favoriteService.removeWhere((service) => service.salonName == salonName);
                              _viewModel.favoriteService.removeWhere(
                                      (service) => service.salonName == salonName);
                            } else {
                              // Add to favorites
                              _viewModel.addFavorite(id);
                              // _viewModel.favoriteService.add(
                              //   Favorite(
                              //     serviceProviderId: serviceProviderId,
                              //     salonName: salonName,
                              //     address: address,
                              //     photo: imagePath,
                              //     averageRating: averageRating.toString(),
                              //   ),
                              // );
                            }
                            _viewModel.refreshUI(); // Notify changes to update UI
                          },

                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: CustomButtonWidget(
                            text: AppString.book,
                            textColor: Colors.white,
                            onPressed: () async {
                              // Call the passed onPressed function
                              onPressed(); // Execute the onPressed callback
                            },
                            buttonColor: fabricColor,
                            borderRadius: 5,
                            buttonHeight: 40,
                          ),
                        ),
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





  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Set the background color of the drawer to white
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xffEDF6F6), // Background color of the DrawerHeader
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(25.0), // Adjust the radius as needed
                      //   bottomRight: Radius.circular(25.0),
                      // ),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/icons/gallery2.png'),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            userName.toString(),
                            style: AppTextStyle.getTextStyle12FontWeightw700,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // List of items with icons
                  ListTile(
                    leading: const Icon(Icons.pending, color: fabricColor),
                    title: Text(AppString.pending, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Get.to(() => BookingPendingPage());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, color: fabricColor),
                    title: Text(AppString.favorite, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Get.to(() => FavoriteServicesPage());
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.notification_important, color: fabricColor),
                  //   title: Text(AppString.notification, style: AppTextStyle.getTextStyle16FontWeightw400,),
                  //   onTap: () {
                  //     Get.to(() => NotificationScreen());
                  //
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                  //     // );
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.credit_card, color: fabricColor),
                    title: Text(AppString.pastBooking, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Get.to(() => PastBookingPage());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit, color: fabricColor),
                    title: Text(AppString.editProfile, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Get.to(() => EditProfilePage());

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                      // );
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.settings, color: fabricColor),
                  //   title: Text(AppString.setting, style: AppTextStyle.getTextStyle16FontWeightw400,),
                  //   onTap: () {
                  //     Get.to(() => SettingsPage());
                  //
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => SettingsPage()),
                  //     // );
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.adb, color: fabricColor),
                  //   title: Text(AppString.rewards, style: AppTextStyle.getTextStyle16FontWeightw400,),
                  //   onTap: () {
                  //     Navigator.pop(context); // Close the drawer
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.help, color: fabricColor),
                    title: Text(AppString.helpAndFAQs, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: fabricColor),
                    title: Text(AppString.privacyPolicy, style: AppTextStyle.getTextStyle16FontWeightw400,),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Optional space before the button
           GestureDetector(
             onTap: () {
               Get.to(() => EmailLoginPage());
               final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
               _sharedPreferenceService.clearCredentials();

               // Navigator.push(
               //   context,
               //   MaterialPageRoute(builder: (context) => EmailLoginPage()),
               // );
             },
             child: Container(
               height: 40,
               width: 120,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                 color: fabricColor,
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Center(
                   child: Row(
                     children: [
                       const Icon(Icons.logout,color: Colors.white,size: 25,),
                       const SizedBox(width: 15),
                       Text(
                         AppString.logout,
                         style: AppTextStyle.getTextStyle14FontWeightw600,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
            const SizedBox(height: 20), // Optional space after the button
          ],
        ),
      ),
    );
  }

}
