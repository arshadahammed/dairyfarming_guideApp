import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/all_lessons.dart';
import 'package:dairyfarm_guide/screens/youtube_screen.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/bookmark_box.dart';
import 'package:dairyfarm_guide/widgets/custom_button.dart';
import 'package:dairyfarm_guide/widgets/custom_image.dart';
import 'package:dairyfarm_guide/widgets/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int maxFailedLoadAttempts = 3;

class CourseDetailPage extends StatefulWidget {
  final Courses data;
  // ignore: prefer_const_constructors_in_immutables
  CourseDetailPage({super.key, required this.data});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Courses courseData;
  // ignore: prefer_final_fields
  List<String> _favoriteIds = [];
  bool _isFavorite = false;

  //ads
  int _interstitialLoadAttempts = 0;

  InterstitialAd? _interstitialAd;

  //ads section
  NativeAd? _nativeAd;
  bool isNativeAdLoaded = false;
  //

  //intrestial
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        }));
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show();
    }
  }

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

    tabController = TabController(length: 2, vsync: this);
    courseData = widget.data;
    loadNativeAd();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _nativeAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      bottomNavigationBar: getFooter(),
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
            tag: courseData.id.toString() + courseData.image,
            child: CustomImage(
              courseData.image,
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
          const SizedBox(
            height: 20,
          ),
          // const SizedBox(height: 5),
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
          getTabBar(),
          getTabBarPages()
        ],
      ),
    );
  }

  Widget getTabBar() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: TabBar(
          controller: tabController,
          indicatorColor: primary,
          tabs: const [
            Tab(
              child: Text(
                "Lessons",
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
            Tab(
              child: Text(
                "Excersises",
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
          ]),
    );
  }

  Widget getTabBarPages() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 200,
      width: double.infinity,
      child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            getLessons(),
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Center(child: Text("Excersises")),
            ),
          ]),
    );
  }

  Widget getLessons() {
    return ListView.builder(
      itemCount: courseData.lessons.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => YoutubeVideoScreen(
                youtubeLink: courseData.lessons[index].video_url,
              ),
            ),
          );
        },
        child: LessonItem(
          data: courseData.lessons[index],
        ),
      ),
    );
  }

  Widget getInfo() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            courseData.name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
          ),
          BookmarkBox(
            isBookmarked: _isFavorite,
            onTap: () async {
              setState(() {
                courseData.is_favorited = !courseData.is_favorited;
                _isFavorite = !_isFavorite;
              });
              await _updateFavorites();
            },
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getAttributes(
                Icons.play_circle_outline, courseData.session, labelColor),
            const SizedBox(
              width: 20,
            ),
            getAttributes(
                Icons.schedule_outlined, courseData.duration, labelColor),
            const SizedBox(
              width: 20,
            ),
            getAttributes(Icons.star, courseData.review, yellow),
          ],
        ),
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
              courseData.description,
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

  Widget getFooter() {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 0),
        )
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                    fontSize: 14,
                    color: labelColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                courseData.price,
                style: const TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: CustomButton(
              title: 'Go to Course',
              onTap: () {
                _showInterstitialAd();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllLessons(
                      data: courseData,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    setState(() {
      if (_favoriteIds.contains(widget.data.id)) {
        // print("Id already exist");
        return;
      }
      if (_isFavorite) {
        favoriteIds.add(widget.data.id);
        // print("After added : ${favoriteIds.length}");
      } else {
        favoriteIds.remove(widget.data.id);
        // print("After removed : ${favoriteIds.length}");
      }
    });

    await prefs.setStringList('favoriteIds', favoriteIds);
  }
}
