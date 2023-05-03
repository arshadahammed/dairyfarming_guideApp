import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/utils/data.dart';
import 'package:dairyfarm_guide/widgets/category_items.dart';
import 'package:dairyfarm_guide/widgets/courses_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  //ads
  final _inlineAdIndex = 1;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;

  //inline Ad
  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }

  int _getListViewItemIndex(int index) {
    if (index >= _inlineAdIndex && _isInlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }

  List<String> _favoriteIds = [];
  //getfav
  Future<void> _getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _createInlineBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _inlineBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            title: getAppBar(),
          ),
          // SliverToBoxAdapter(
          //   child: getSearchBox(),
          // ),
          // SliverToBoxAdapter(
          //   child: getCategories(),
          // ),
          SliverList(delegate: getCourses())
        ],
      ),
    );
  }

  getAppBar() {
    return Container(
      child: Row(
        children: const [
          Text(
            "Explore All Courses",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ],
      ),
    );
  }

  //search
  getSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  color: textBoxColor,
                  border: Border.all(color: textBoxColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.5),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/filter.svg",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  int selectedCategoryIndex = 0;
  getCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 15),
      child: Row(
          children: List.generate(
              categories.length,
              (index) => CategoryItem(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    isActive: selectedCategoryIndex == index,
                    data: categories[index],
                  ))),
    );
  }

  getCourses() {
    return SliverChildBuilderDelegate(
      (context, index) {
        if (_isInlineBannerAdLoaded && index == _inlineAdIndex) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            width: _inlineBannerAd.size.width.toDouble(),
            height: _inlineBannerAd.size.height.toDouble(),
            child: AdWidget(ad: _inlineBannerAd),
          );
        }
        if (_isInlineBannerAdLoaded && index == _inlineAdIndex) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            width: _inlineBannerAd.size.width.toDouble(),
            height: _inlineBannerAd.size.height.toDouble(),
            child: AdWidget(ad: _inlineBannerAd),
          );
        }
        return Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseDetailPage(
                          data: allCourses[_getListViewItemIndex(index)],
                        )));
              },
              child: CourseItem(
                data: allCourses[_getListViewItemIndex(index)],
                onBookmark: () {
                  setState(() {
                    allCourses[index].is_favorited =
                        !allCourses[index].is_favorited;
                  });
                },
              ),
            ));
      },
      childCount: allCourses.length + (_isInlineBannerAdLoaded ? 1 : 0),
    );
  }
}
