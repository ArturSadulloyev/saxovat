import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/message_model.dart';
import 'package:saxovat/services/db_services.dart';

class CommentPage extends StatelessWidget {
  final Message msg;
  final Charity charity;
  TextEditingController msgController = TextEditingController();

  CommentPage({Key? key, required this.msg,required this.charity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              // Image(image: NetworkImage(post.imageUrl)),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   post.content,
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.message,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(
                              //   "${msg.writtenAt.hour.toString().padLeft(2, "0")} : ${msg.writtenAt.minute.toString().padLeft(2, "0")}",
                              //   style: Theme.of(context).textTheme.bodyLarge,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    msg.message,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.deepPurple,
                                    child: Text(
                                      charity.title.substring(0, 1),
                                      style: Theme.of(context)
                                          .textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.blue.shade800,
                height: 80,
                child: TextField(
                  controller: msgController,
                  decoration: InputDecoration(
                    hintText: "  Write a comment...",
                    hintStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        DBService.storeMessage(msgController.text,  charity.userId,
                          charity.id);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onSubmitted: (text) {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// StreamBuilder(
//   stream: DBService.db.ref(Folder.post).child(post.id).onValue,
//   builder: (context, snapshot) {
//
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: message.,
//       itemBuilder: (context, index) {
//         final msg = current.comments[index];
//
//         if (AuthService.user.uid == msg.userId) {
//           return Row(
//             children: [
//               const Expanded(
//                 flex: 1,
//                 child: SizedBox.shrink(),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         msg.message,
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleMedium,
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment:
//                         CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "${msg.writtenAt.hour.toString().padLeft(2, "0")} : ${msg.writtenAt.minute.toString().padLeft(2, "0")}",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge,
//                           ),
//                           Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 msg.username,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall,
//                               ),
//                               const SizedBox(width: 10),
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor:
//                                 Colors.deepPurple,
//                                 child: Text(
//                                   msg.username.substring(0, 1),
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineLarge,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//
//         return Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 margin: const EdgeInsets.symmetric(vertical: 5),
//                 decoration: BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       msg.message,
//                       style:
//                       Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               radius: 20,
//                               backgroundColor:
//                               Colors.lightBlueAccent,
//                               child: Text(
//                                 msg.username.substring(0, 1),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineLarge,
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               msg.username,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall,
//                             )
//                           ],
//                         ),
//                         Text(
//                           "${msg.writtenAt.hour.toString().padLeft(2, "0")} : ${msg.writtenAt.minute.toString().padLeft(2, "0")}",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             const Expanded(
//               flex: 1,
//               child: SizedBox.shrink(),
//             ),
//           ],
//         );
//       },
//     );
//   },
// ),
