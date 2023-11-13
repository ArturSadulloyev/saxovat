import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/message_model.dart';
import 'package:saxovat/pages/charityPage/about_charity.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Message> msgList = [];
  List<Charity> charityList = [];
  bool isLoading = false;

  void findMessage() async {
    setState(() {
      isLoading = true;
    });
    msgList = await DBService.readAllMessage(Auth.auth.currentUser!.uid);
    msgList.forEach((element) {
      print(element.message);
    });

    setState(() {
      isLoading = false;
    });
  }

  void findCharity() async {
    List<Charity> charList = await DBService.readAllPost();
    final msgList2 = await DBService.readAllMessage(Auth.auth.currentUser!.uid);
    Set<Charity> setCharity = {};
    Set<Message> setMsg = {};
    for (int i = 0; i < charList.length; i++) {
      for (int j = 0; j < msgList2.length; j++) {
        if (charList[i].id == msgList2[j].id) {
          setCharity.add(charList[i]);
          setMsg.add(msgList2[j]);
        }
      }
    }
    charityList = setCharity.toList();
    msgList = setMsg.toList();
    print('lee ${charityList.length}');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    findMessage();
    findCharity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Xabarlar',
              style: font(
                size: 22,
                color: Colors.red,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: ListView.builder(
            itemCount: charityList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AboutCharity(charity: charityList[index])));
                },
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      charityList[index].title,
                      style: font(
                          size: 15,
                          color: Colors.black,
                          weight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Container(
                        height: 150,
                        width: 80,
                        child: Image.network(
                          charityList[index].imageUrl,
                          fit: BoxFit.cover,
                        )),
                    // trailing:
                    // Container(
                    //   height: 15,
                    //   width: 100,
                    //   child: Text(
                    //     msgList[index].message,
                    //     style: font(
                    //         size: 15,
                    //         color: Colors.black,
                    //         weight: FontWeight.w400),
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                  ),
                ),
              );
            },
          ),
        ),
        if (isLoading)
          Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.transparent,
          )),
      ],
    );
  }
}
