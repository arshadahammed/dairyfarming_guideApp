import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/course_details.dart';
import 'package:dairyfarm_guide/screens/main_screen.dart';
import 'package:dairyfarm_guide/theme/color.dart';

import 'package:dairyfarm_guide/widgets/recommend_item.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int maxFailedLoadAttempts = 3;

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  final _inlineAdIndex = 0;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;

  int _interstitialLoadAttempts = 0;

  InterstitialAd? _interstitialAd;
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
  List<Courses> favoriteCourses = [];
  bool isListEmpty = false;

  // Future<void> _getFavorites() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
  //   print("_favoriteIds length = ${_favoriteIds.length}");
  //   setState(() {
  //     favoriteCourses = allCourses
  //         .where((course) => _favoriteIds.contains(course.id))
  //         .toList();
  //     print("_favoriteIds length = ${favoriteCourses.length}");
  //   });
  // }
  Future<void> _getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    });
  }

  Future<void> _clearFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    // });

    await prefs.remove('favoriteIds');
    setState(() {
      _favoriteIds = [];
    });
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _getFavorites();

    _createInlineBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _inlineBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        //centerTitle: true,
        title: const Text("Bookmarked Courses",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 18)),
        iconTheme: const IconThemeData(color: textColor),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   color: Colors.black,
        //   icon: const Icon(Icons.arrow_back_ios),
        // ),
      ),
      body: ListView.builder(
        itemCount: _favoriteIds.length + (_isInlineBannerAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
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
          final favoriteId = _favoriteIds[_getListViewItemIndex(index)];

          return FutureBuilder(
            future: _getItemById(favoriteId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //  print(_favoriteIds);
                // ignore: unused_local_variable
                final Courses course = snapshot.data as Courses;
                //  print(favoriteId.length);
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: RecommendItem(
                    data: allCourses[_getListViewItemIndex(index)],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CourseDetailPage(
                                data: allCourses[_getListViewItemIndex(index)],
                              )));
                    },
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: Text('There is no Item addeed'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _favoriteIds.isEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              backgroundColor: Colors.brown,
              icon: const Icon(
                Icons.add_chart,
                color: Colors.white,
                size: 32,
              ),
              label: const Text(
                "Add Courses to favourite ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : FloatingActionButton.extended(
              onPressed: () {
                _showInterstitialAd();
                _clearFavorites();
              },
              backgroundColor: Colors.brown,
              icon: const Icon(
                Icons.clear_all_sharp,
                color: Colors.white,
                size: 32,
              ),
              label: const Text(
                "CLear Favourite List",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Future<Courses> _getItemById(String itemId) async {
    // Replace this with your own code to retrieve the item by its id
    return allCourses.firstWhere((product) => product.id == itemId);
  }
}
