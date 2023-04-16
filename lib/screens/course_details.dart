import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/all_lessons.dart';
import 'package:dairyfarm_guide/screens/youtube_screen.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/utils/data.dart';
import 'package:dairyfarm_guide/widgets/bookmark_box.dart';
import 'package:dairyfarm_guide/widgets/custom_button.dart';
import 'package:dairyfarm_guide/widgets/custom_image.dart';
import 'package:dairyfarm_guide/widgets/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CourseDetailPage extends StatefulWidget {
  final Courses data;
  CourseDetailPage({super.key, required this.data});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Courses courseData;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    courseData = widget.data;
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
      title: Text(
        "Detail",
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
          getTabBar(),
          getTabBarPages()
        ],
      ),
    );
  }

  Widget getTabBar() {
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
    return Container(
      height: 200,
      width: double.infinity,
      child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            getLessons(),
            Container(
              child: Center(child: Text("Excersises")),
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
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            courseData.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
          ),
          BookmarkBox(
            isBookmarked: courseData.is_favorited,
            onTap: () {
              setState(() {
                courseData.is_favorited = !courseData.is_favorited;
              });
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
          style: TextStyle(color: labelColor),
        )
      ],
    );
  }

  Widget getFooter() {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 0),
        )
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    fontSize: 14,
                    color: labelColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                courseData.price,
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(width: 30),
          Expanded(
            child: CustomButton(
              title: 'Go to Course',
              onTap: () {
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
}
