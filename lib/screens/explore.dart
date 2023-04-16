import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/utils/data.dart';
import 'package:dairyfarm_guide/widgets/category_items.dart';
import 'package:dairyfarm_guide/widgets/courses_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
          SliverToBoxAdapter(
            child: getSearchBox(),
          ),
          SliverToBoxAdapter(
            child: getCategories(),
          ),
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
            "Explore",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 24),
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
        return Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: CourseItem(
              data: courses[index],
              onBookmark: () {
                setState(() {
                  courses[index]["is_favorited"] =
                      !courses[index]["is_favorited"];
                });
              },
            ));
      },
      childCount: courses.length,
    );
  }
}
