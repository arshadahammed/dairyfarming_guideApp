// import 'package:dairyfarm_guide/utils/data.dart';
// import 'package:dairyfarm_guide/widgets/chat_item.dart';
// import 'package:dairyfarm_guide/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   @override
//   Widget build(BuildContext context) {
//     return buildBody();
//   }

//   buildBody() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(left: 15, right: 15),
//       child: Column(children: [
//         getHeader(),
//         getChats(),
//       ]),
//     );
//   }

//   getHeader() {
//     return Container(
//         padding: const EdgeInsets.fromLTRB(0, 60, 0, 5),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const Text(
//                         "Chat",
//                         style: TextStyle(
//                             fontSize: 28,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w600),
//                       )),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             CustomTextBox(
//               hint: "Search",
//               prefix: const Icon(Icons.search, color: Colors.grey),
//             ),
//           ],
//         ));
//   }

//   getChats() {
//     return ListView(
//         padding: const EdgeInsets.only(top: 10),
//         shrinkWrap: true,
//         children: List.generate(
//             chats.length,
//             (index) => ChatItem(
//                   chats[index],
//                   onTap: () {},
//                 )));
//   }
// }
