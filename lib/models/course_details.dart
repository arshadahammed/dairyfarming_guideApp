import 'package:dairyfarm_guide/models/lessons.dart';

class Courses {
  final String id, name, image, price, duration, session, review, description;
  bool is_favorited, is_recommented;
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
    required this.is_recommented,
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
    session: introLessons.length.toString(),
    review: "4.5",
    description:
        " This course provides an overview of the history and evolution of dairy farming, introduces the modern dairy industry and its terminology and concepts, discusses the different types of dairy farms, and covers animal welfare and ethical considerations in dairy farming.",
    is_favorited: true,
    is_recommented: false,
    lessons: introLessons,
  ),
  Courses(
    id: "2",
    name: "Dairy Cattle Breeds",
    image:
        "https://images.unsplash.com/photo-1596733430284-f7437764b1a9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: dairyBreeds.length.toString(),
    review: "4.2",
    description:
        " This course covers the different types of dairy cattle breeds and their characteristics, explains the selection criteria for dairy cattle, discusses genetic improvement and breeding strategies, and describes how to manage a dairy herd based on breed type.",
    is_favorited: true,
    is_recommented: true,
    lessons: dairyBreeds,
  ),
  Courses(
    id: "3",
    name: "Dairy Nutrition Management",
    image:
        "https://images.unsplash.com/photo-1629313472434-cbbfdc2e1a5f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "${dairyNutrition.length.toString()} + Lessons",
    review: "4.5",
    description:
        "Dairy Nutrition: Feeding and Management - This course covers the nutritional requirements of dairy cattle, the different types of feed and how to formulate rations, feed management and delivery systems, and ways to optimize production efficiency through good nutrition.",
    is_favorited: true,
    is_recommented: false,
    lessons: dairyNutrition,
  ),
  Courses(
    id: "4",
    name: "Health & Disease",
    image:
        "https://images.unsplash.com/photo-1606262482954-f405e0946f4d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=875&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "${diseaseManagement.length.toString()} + Lessons",
    review: "4.5",
    description:
        "Dairy Herd Health and Disease Management - This course covers the common diseases and ailments that affect dairy cattle, strategies for preventative health management, herd health management, record-keeping and data analysis for herd health, and animal welfare considerations in health management.",
    is_favorited: true,
    is_recommented: true,
    lessons: diseaseManagement,
  ),
  Courses(
    id: "5",
    name: "Milk Quality& Testing",
    image:
        "https://cdn.pixabay.com/photo/2018/06/05/12/25/milk-3455394_960_720.jpg",
    price: "Free",
    duration: "7 Hours",
    session: "${milkManagement.length.toString()} + Lessons",
    review: "4.5",
    description:
        "This course covers the factors that affect milk quality, testing methods for milk quality, microbiology and safety considerations, milk handling and storage best practices, and quality assurance and control programs.",
    is_favorited: true,
    is_recommented: false,
    lessons: milkManagement,
  ),

  //https://images.unsplash.com/photo-1523473827533-2a64d0d36748?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80

  Courses(
    id: "6",
    name: "Dairy Business Management",
    image:
        "https://images.unsplash.com/photo-1626561921730-200b9a3ecc95?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "${bussinessManagement.length.toString()} + Lessons",
    review: "4.5",
    description:
        "This course covers financial management and budgeting, profitability analysis, marketing and sales of dairy products, labor management and human resources, and risk management and insurance considerations.",
    is_favorited: true,
    is_recommented: false,
    lessons: bussinessManagement,
  ),

  Courses(
    id: "7",
    name: "Things You Must know",
    image:
        "https://images.unsplash.com/photo-1567879656049-f2265f23d8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80",
    price: "Free",
    duration: "7 Hours",
    session: "${mustKnow.length.toString()} + Lessons",
    review: "4.5",
    description:
        "This course covers sustainable dairy farming practices, the environmental impacts of dairy farming, waste management ",
    is_favorited: true,
    is_recommented: true,
    lessons: mustKnow,
  ),
];
