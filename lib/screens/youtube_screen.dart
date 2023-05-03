import 'package:dairyfarm_guide/ads_helper/ads_helper.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final String youtubeLink;
  const YoutubeVideoScreen({
    Key? key,
    required this.youtubeLink,
  }) : super(key: key);

  @override
  State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late YoutubePlayerController _controller;

  //ads section
  NativeAd? _nativeAd;
  bool isNativeAdLoaded = false;

  // late BannerAd _bottomBannerAd;

  // bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadNativeAd();
    // _createBottomBannerAd();
    final videoID = YoutubePlayer.convertUrlToId(widget.youtubeLink);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
  }

  //Banner Ad
  // void _createBottomBannerAd() {
  //   _bottomBannerAd = BannerAd(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(onAdLoaded: (_) {
  //       setState(() {
  //         _isBottomBannerAdLoaded = true;
  //       });
  //     }, onAdFailedToLoad: (ad, error) {
  //       ad.dispose();
  //     }),
  //   );
  //   _bottomBannerAd.load();
  // }

  //loadNative Ad
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
  void dispose() {
    super.dispose();
    // _bottomBannerAd.dispose();
    _nativeAd!.dispose();
    // _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   centerTitle: true,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     color: greenColor,
      //     icon: const Icon(Icons.arrow_back_ios),
      //   ),
      //   title: Text(
      //     "Recipe Video",
      //     style: titleGreenStyle(),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          "Video",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
      // bottomNavigationBar: _isBottomBannerAdLoaded
      //     ? Container(
      //         alignment: Alignment.center,
      //         height: _bottomBannerAd.size.height.toDouble(),
      //         width: _bottomBannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bottomBannerAd),
      //       )
      //     : null,
    );
  }
}
