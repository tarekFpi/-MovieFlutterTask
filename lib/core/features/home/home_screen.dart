
import 'package:basie_project/core/features/home/home_controller.dart';
import 'package:basie_project/core/features/home/model/MovieResponse.dart';
import 'package:basie_project/core/features/home/search_screen.dart';
import 'package:basie_project/core/features/theme/color_scheme.dart';
import 'package:basie_project/core/features/utils/hexcolor.dart';
import 'package:basie_project/core/features/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';


 class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {

   final homeController = Get.put(HomeController());

   final queryEditingController = TextEditingController();

   String query = "";

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeController.showMovielist();
  }

   void goToDetails(Search searchResponse){

     FocusScope.of(context).unfocus();

     Get.to(() => SearchDetails(movielist: searchResponse));

   }

   @override
   Widget build(BuildContext context) {
     final colorScheme = Theme.of(context).colorScheme;
     final textTheme = Theme.of(context).textTheme;

     return Scaffold(
       backgroundColor:colorScheme.surfaceVariant,
         appBar: AppBar(
           backgroundColor:Colors.redAccent,
             elevation: 2,
             centerTitle: true,
             title: Text(
               "Home page",
               style: textTheme.titleMedium?.copyWith(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold),
             ) ),

        body: SingleChildScrollView(
      child: Container(
       padding: const EdgeInsets.symmetric(horizontal: 12),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [

           SizedBox(height: 12,),

           TextField(
             style: textTheme.bodyMedium,
             controller: queryEditingController,
             onChanged: (value) {
               setState(() {
                 query = value;
               });
               homeController.filterMovie(value);
             },
             decoration: InputDecoration(
                 contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                 hintText: "Search for year",
                 hintStyle: textTheme.bodyMedium
                     ?.copyWith(color: Colors.grey),
                 suffixIcon: query.isBlank == true || query.isEmpty
                     ? Icon(
                   FluentIcons.search_24_regular,
                   color: HexColor("#BCC2EB"),
                 )
                     : IconButton(
                     icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                     onPressed: () {
                       //clear query
                       setState(() {
                         query = "";
                       });
                       queryEditingController.clear();
                       FocusScope.of(context).unfocus();
                       homeController.filterMovie(null);
                     })),
           ),

           SizedBox(height: 12,),

           Card(
             elevation: 2,
             child: ImageSlideshow(
               width: double.infinity,
               height: 150,
               initialPage: 0,
               indicatorColor: Colors.blue,
               indicatorBackgroundColor: Colors.grey,
               onPageChanged: (value) {
                 debugPrint('Page changed: $value');
               },
               autoPlayInterval: 3000,
               isLoop: true,
               children: [

                 Image.asset('assets/images/image1.jpg', fit: BoxFit.fill),
                 Image.asset('assets/images/image2.jpg', fit: BoxFit.fill),
                 Image.asset('assets/images/image3.jpg', fit: BoxFit.fill),
               ],
             ),
           ),

           const SizedBox(
             height: 8,
           ),

           homeController.obx((state) => RefreshIndicator(
             onRefresh:homeController.showMovielist,
             child: ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: state!.length,
                 itemBuilder: (BuildContext context,index){

                   return InkWell(
                     onTap: (){
                       goToDetails(state[index]);
                     },
                     child: SizedBox(
                       height: 200,
                       child: Card(
                         color:  HexColor("#FAFDFC"),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [


                               Image.network("${state[index].poster}",height: 150,width: 300, fit: BoxFit.fill),

                               const SizedBox(
                                 height: 4,
                               ),

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [

                                   SizedBox(

                                     child: Text(
                                       "title :${state[index].title}",
                                       style: textTheme.bodySmall?.copyWith(
                                           color: lightColorScheme.primary,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ),

                                   Text(
                                     "year :${state[index].year}",
                                     style: textTheme.bodySmall?.copyWith(
                                         color: lightColorScheme.primary,
                                         fontSize: 14,
                                         fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 }),

           ),onError: (msg) {
             return CustomErrorWidget(
                 icon: Icon(
                   msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                   color: Colors.red,
                   size: 40,
                 ),
                 btnLevel: "Retry",
                 message: msg.toString(),
                 onClick: () {
                   homeController.showMovielist();
                 });
           }),
         ],
       ),
     ),
        ),
     );
   }
 }
