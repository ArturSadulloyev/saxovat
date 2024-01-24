import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/services/network.dart';
import 'package:saxovat/views/font.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../views/no_internet_page.dart';

class AddCharityPage extends StatefulWidget {
  const AddCharityPage({super.key, this.cardNumber});

  final String? cardNumber;

  @override
  State<AddCharityPage> createState() => _AddCharityPageState();
}

class _AddCharityPageState extends State<AddCharityPage> {
  final ImagePicker picker = ImagePicker();
  File? file;
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController locationController = TextEditingController();
  TextEditingController cardNumBerController = TextEditingController();
  bool isLoading = false;
  List<File> imageList = [];

  void getImage() async {
    var xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      // imageList.add(file!);
      print(file);
      setState(() {});
    }
  }

  String _myState = 'Xayriya';
  var statesList = ['Xayriya', 'Hashar'];
  bool checkInternet = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: Text(
          "new_project".tr(),
          style: font(size: 22, color: Colors.white, weight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 150,
                    width: double.maxFinite,
                    //   padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: getImage,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color: Colors.blue.shade200),
                              child: file == null
                                  ? const Icon(
                                      Icons.add,
                                      size: 60,
                                    )
                                  : Image.file(
                                      file!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// Sarlavha
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "title".tr(),
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                          fontSize: 18,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),

                  const SizedBox(height: 40),

                  /// Batafsil ma'lumot
                  TextField(
                    //keyboardType: TextInputType.text,
                    controller: descriptionController,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "learn_more".tr(),
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                          fontSize: 18,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  widget.cardNumber != null
                      ? const SizedBox(height: 40)
                      : const SizedBox.shrink(),
                  widget.cardNumber != null
                      ? TextField(
                          keyboardType: TextInputType.text,
                          controller: cardNumBerController,
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(width: 0.2)),
                              labelText: "card_number".tr(),
                              labelStyle: TextStyle(
                                // color: Colors.blue,
                                fontSize: 18,
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 40),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: locationController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "address".tr(),
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                          fontSize: 18,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty ||
                            file!.path.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling"),
                            ),
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          checkInternet = await checkInternetConnection();
                          if (checkInternet) {
                            final id = Uuid().v4();
                            final imageUrl = await StoreService.uploadFile(file!);

                            Map<String, Object> data = {
                              "title": titleController.text,
                              "content": descriptionController.text,
                              "category": widget.cardNumber == null
                                  ? 'Hashar'
                                  : 'Xayriya',
                              "location": locationController.text,
                              "userId": user?.uid ?? 1,
                              "cardNumber": widget.cardNumber ?? '',
                              "imageUrl": imageUrl,
                              "createdAt": DateTime.now().toString(),
                              "description": descriptionController.text,
                              "charityId": id,
                            };

                            Map<String, Object?> data2 = {
                              "approve": false,
                              "charityId": id,
                            };


                            await Network.methodPost(
                              api: Network.apiMainCharity,
                              data: data2,
                            );

                            await Network.methodPost(
                              api: Network.apiCharity,
                              data: data,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Loyihangiz tekshiruv uchun yuborildi!"),
                              ),
                            );
                          }
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child:  Text(
                        "save".tr(),
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 60)
                ],
              ),
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (!checkInternet)
            NoInternetPage(
              function: () {},
              function1: () {},
              ctx: context,
            ),
        ],
      ),
    );
  }
}
