import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairyfarm_guide/models/categories.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/categories/category_details.dart';
import 'package:dairyfarm_guide/screens/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/utils/data.dart';
import 'package:dairyfarm_guide/widgets/category_box.dart';
import 'package:dairyfarm_guide/widgets/feature_item.dart';
import 'package:dairyfarm_guide/widgets/recommend_item.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: UpgradeAlert(
          upgrader: Upgrader(
            shouldPopScope: () => true,
            canDismissDialog: true,
            durationUntilAlertAgain: const Duration(days: 1),
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: appBarColor,
                pinned: true,
                snap: true,
                floating: true,
                title: getAppBar(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => buildBody(),
                  childCount: 1,
                ),
              )
            ],
          ),
        ));
  }

  Widget getAppBar() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile["name"]!,
                style: const TextStyle(
                  color: labelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Welcome!",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ],
          )),
          // NotificationBox(
          //   notifiedNumber: 1,
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getCategories(),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text("Featured",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          getFeature(),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          getRecommend(),
        ]),
      ),
    );
  }

  int selectedCollection = 0;
  getCategories() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              allCategories.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CategoryBox(
                    selectedColor: Colors.white,
                    data: allCategories[index],
                    onTap: () {
                      setState(() {
                        selectedCollection = index;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryDetailsPage(
                                data: allCategories[index],
                              )));
                    },
                  )))),
    );
  }

  getFeature() {
    return CarouselSlider(
        options: CarouselOptions(
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(
            allCourses.length,
            (index) => FeatureItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseDetailPage(
                            data: allCourses[index],
                          )));
                },
                data: allCourses[index])));
  }

  getRecommend() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(allCourses.length, (index) {
        if (allCourses[index].is_recommented) {
          return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: RecommendItem(
                data: allCourses[index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseDetailPage(
                            data: allCourses[index],
                          )));
                },
              ));
        }
        return const SizedBox.shrink();
      })),
    );
  }
}
