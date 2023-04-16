import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/screens/youtube_screen.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AllLessons extends StatefulWidget {
  final Courses data;
  const AllLessons({super.key, required this.data});

  @override
  State<AllLessons> createState() => _AllLessonsState();
}

class _AllLessonsState extends State<AllLessons> {
  late Courses courseData;
  @override
  void initState() {
    super.initState();
    courseData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        ),
        body: getLessons());
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
}
