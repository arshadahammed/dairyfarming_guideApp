import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/models/categories.dart';

import 'package:dairyfarm_guide/theme/color.dart';

import 'package:dairyfarm_guide/widgets/custom_image.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CategoryDetailsPage extends StatefulWidget {
  final MainCategories data;
  const CategoryDetailsPage({super.key, required this.data});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late TabController tabController;
  late MainCategories categoryData;
  late YoutubePlayerController _controller;

  //ads section
  NativeAd? _nativeAd;
  bool isNativeAdLoaded = false;

  void loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        _nativeAd!.dispose();
      }),
      request: const AdRequest(),
    );
    _nativeAd!.load();
  }

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 2, vsync: this);
    //ypitube
    final videoID = YoutubePlayer.convertUrlToId(widget.data.videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    categoryData = widget.data;
    loadNativeAd();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      // bottomNavigationBar: getFooter(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: const Text(
        "Detail",
        style: TextStyle(
          color: textColor,
        ),
      ),
      iconTheme: const IconThemeData(color: textColor),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.black,
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          Hero(
            tag: categoryData.id.toString() + categoryData.image,
            child: CustomImage(
              categoryData.image,
              radius: 10,
              width: double.infinity,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          getInfo(),
          const Divider(),
          isNativeAdLoaded
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 265,
                  child: AdWidget(
                    ad: _nativeAd!,
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              debugPrint('ready');
            },
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                    playedColor: Colors.red, handleColor: Colors.redAccent),
              ),
              const PlaybackSpeedButton(),
            ],
          ),
          const SizedBox(height: 25),
          // getTabBar(),
          // getTabBarPages()
        ],
      ),
    );
  }

  // Widget getTabBar() {
  //   return Container(
  //     child: TabBar(
  //         controller: tabController,
  //         indicatorColor: primary,
  //         tabs: const [
  //           Tab(
  //             child: Text(
  //               "Lessons",
  //               style: TextStyle(fontSize: 16, color: textColor),
  //             ),
  //           ),
  //           Tab(
  //             child: Text(
  //               "Excersises",
  //               style: TextStyle(fontSize: 16, color: textColor),
  //             ),
  //           ),
  //         ]),
  //   );
  // }

  // Widget getTabBarPages() {
  //   return Container(
  //     height: 200,
  //     width: double.infinity,
  //     child: TabBarView(
  //         controller: tabController,
  //         physics: const NeverScrollableScrollPhysics(),
  //         children: [
  //           getLessons(),
  //           Container(
  //             child: Center(child: Text("Excersises")),
  //           ),
  //         ]),
  //   );
  // }

  // Widget getLessons() {
  //   return ListView.builder(
  //     itemCount: courseData.lessons.length,
  //     itemBuilder: (context, index) => GestureDetector(
  //       onTap: () {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => YoutubeVideoScreen(
  //               youtubeLink: courseData.lessons[index].video_url,
  //             ),
  //           ),
  //         );
  //       },
  //       child: LessonItem(
  //         data: courseData.lessons[index],
  //       ),
  //     ),
  //   );
  // }

  Widget getInfo() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            categoryData.name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
          ),
          // BookmarkBox(
          //   isBookmarked: courseData.is_favorited,
          //   onTap: () {
          //     setState(() {
          //       courseData.is_favorited = !courseData.is_favorited;
          //     });
          //   },
          // ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Course",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
            ),
            const SizedBox(
              height: 10,
            ),
            ReadMoreText(
              categoryData.description,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: "Show more",
              moreStyle: const TextStyle(
                  fontSize: 14, color: primary, fontWeight: FontWeight.w500),
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: labelColor),
            )
          ],
        )
      ],
    ));
  }

  Widget getAttributes(IconData icon, String info, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          info,
          style: const TextStyle(color: labelColor),
        )
      ],
    );
  }

  // Widget getFooter() {
  //   return Container(
  //     height: 80,
  //     width: double.infinity,
  //     padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
  //     decoration: BoxDecoration(color: Colors.white, boxShadow: [
  //       BoxShadow(
  //         color: shadowColor.withOpacity(.05),
  //         spreadRadius: 1,
  //         blurRadius: 1,
  //         offset: Offset(0, 0),
  //       )
  //     ]),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               'Price',
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   color: labelColor,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //             SizedBox(
  //               height: 3,
  //             ),
  //             Text(
  //               courseData.price,
  //               style: TextStyle(
  //                   fontSize: 18,
  //                   color: textColor,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //           ],
  //         ),
  //         SizedBox(width: 30),
  //         Expanded(
  //           child: CustomButton(
  //             title: 'Go to Course',
  //             onTap: () {
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (context) => AllLessons(
  //                     data: courseData,
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
