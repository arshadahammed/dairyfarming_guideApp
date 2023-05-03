import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/youtube_screen.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AllLessons extends StatefulWidget {
  final Courses data;
  const AllLessons({super.key, required this.data});

  @override
  State<AllLessons> createState() => _AllLessonsState();
}

class _AllLessonsState extends State<AllLessons> {
  late Courses courseData;
  final _inlineAdIndex = 2;
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

  @override
  void initState() {
    super.initState();
    courseData = widget.data;
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
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Text(
            "All lessons",
            style: TextStyle(
              color: textColor,
            ),
          ),
          iconTheme: IconThemeData(color: textColor),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: getLessons());
  }

  Widget getLessons() {
    return ListView.builder(
        itemCount:
            courseData.lessons.length + (_isInlineBannerAdLoaded ? 1 : 0),
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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => YoutubeVideoScreen(
                    youtubeLink: courseData
                        .lessons[_getListViewItemIndex(index)].video_url,
                  ),
                ),
              );
            },
            child: LessonItem(
              data: courseData.lessons[_getListViewItemIndex(index)],
            ),
          );
        });
  }
}
