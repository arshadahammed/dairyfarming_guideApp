import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/utils/data.dart';
import 'package:dairyfarm_guide/widgets/category_items.dart';
import 'package:dairyfarm_guide/widgets/courses_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteList2 extends StatefulWidget {
  const FavouriteList2({super.key});

  @override
  State<FavouriteList2> createState() => _FavouriteList2State();
}

class _FavouriteList2State extends State<FavouriteList2> {
  List<String> _favoriteIds = [];
  List<Courses> favoriteCourses = [];
  bool isListEmpty = false;

  Future<void> _getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    //print("_favoriteIds length = ${_favoriteIds.length}");
    setState(() {
      favoriteCourses = allCourses
          .where((course) => _favoriteIds.contains(course.id))
          .toList();
      //print("_favoriteIds length = ${favoriteCourses.length}");
    });
  }

  // ignore: unused_element
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
    _getFavorites();
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
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        children: const [
          Text(
            "Your Favourite Courses",
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
              padding: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  color: textBoxColor,
                  border: Border.all(color: textBoxColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.5),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: const Offset(0, 0),
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
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/filter.svg",
              // ignore: deprecated_member_use
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
        return Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseDetailPage(
                          data: allCourses[index],
                        )));
              },
              child: CourseItem(
                data: favoriteCourses[index],
                onBookmark: () {
                  setState(() {
                    allCourses[index].is_favorited =
                        !allCourses[index].is_favorited;
                  });
                },
              ),
            ));
      },
      childCount: favoriteCourses.length,
    );
  }

  //   getCourses() {
  //   return SliverChildBuilderDelegate(
  //     (context, index) {
  //       return Padding(
  //           padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
  //           child: CourseItem(
  //             data: favoriteCourses[index],
  //             onBookmark: () {
  //               setState(() {
  //                 allCourses[index].is_favorited =
  //                     !allCourses[index].is_favorited;
  //               });
  //             },
  //           ));
  //     },
  //     childCount: favoriteCourses.length,
  //   );
  // }
}
