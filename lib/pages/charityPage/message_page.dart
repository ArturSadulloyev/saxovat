import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/message_model.dart';
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
    msgList = await DBService.readAllMessage(Auth.auth.currentUser!.uid);



    for(int i=0;i<charList.length;i++){
      for(int j=0;j<msgList.length;j++){
        if(charList[i].id==msgList[j].id){
          if(!charityList.contains(charList[i])){
            charityList.add(charList[i]);
          }
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }



  @override
  void initState() {
    findMessage();
    findCharity();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: ListView.builder(
            itemCount: charityList.length,
            itemBuilder: (context, index) {

              return ListTile(
                title: Text(
                  msgList[0].message,
                  style: font(size: 18),
                ),
                leading: Image.network(charityList[index].imageUrl),
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
