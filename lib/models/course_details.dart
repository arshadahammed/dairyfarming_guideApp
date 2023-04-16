import 'package:dairyfarm_guide/models/lessons.dart';

class Courses {
  final String id, name, image, price, duration, session, review, description;
  bool is_favorited;
  final List<Lessons> lessons;
  Courses({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.duration,
    required this.session,
    required this.review,
    required this.description,
    required this.is_favorited,
    required this.lessons,
  });
}

List<Courses> allCourses = [
  Courses(
    id: "1",
    name: "Dairy Farming Introduction",
    image:
        "https://images.unsplash.com/photo-1629313471551-ba2052384b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "5 Lessons",
    review: "4.5",
    description:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
    is_favorited: true,
    lessons: introLessons,
  ),
  Courses(
    id: "2",
    name: "Dairy Farming Management",
    image:
        "https://images.unsplash.com/photo-1629313471551-ba2052384b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "5 Lessons",
    review: "4.5",
    description:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
    is_favorited: true,
    lessons: introLessons,
  ),
  Courses(
    id: "3",
    name: "Dairy Farming Management",
    image:
        "https://images.unsplash.com/photo-1629313471551-ba2052384b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "5 Lessons",
    review: "4.5",
    description:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
    is_favorited: true,
    lessons: introLessons,
  ),
  Courses(
    id: "4",
    name: "Dairy Farming Management",
    image:
        "https://images.unsplash.com/photo-1629313471551-ba2052384b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "5 Lessons",
    review: "4.5",
    description:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
    is_favorited: true,
    lessons: introLessons,
  ),
  Courses(
    id: "5",
    name: "Dairy Farming Management",
    image:
        "https://images.unsplash.com/photo-1629313471551-ba2052384b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "5 Lessons",
    review: "4.5",
    description:
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
    is_favorited: true,
    lessons: introLessons,
  ),
];
