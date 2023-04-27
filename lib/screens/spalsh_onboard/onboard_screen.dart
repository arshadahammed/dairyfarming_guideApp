import 'package:dairyfarm_guide/screens/home.dart';
import 'package:dairyfarm_guide/screens/root_app.dart';
import 'package:dairyfarm_guide/utils/constant.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  // AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  @override
  void initState() {
    super.initState();
    // appOpenAdManager.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/png/onboard.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            color: grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Do you want to start a dairy farm',
                    textAlign: TextAlign.center,
                    style: roboto.copyWith(
                        fontSize: 24, height: 1.5, color: black),
                  ),
                  Text(
                    'Don\'t be confused, You are in the best place',
                    textAlign: TextAlign.center,
                    style: roboto.copyWith(
                        color: black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 2),
                  ),
                  GestureDetector(
                    onTap: () {
                      // appOpenAdManager.showAdIfAvailable();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootApp()),
                          (route) => false);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: green),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: poppins.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}