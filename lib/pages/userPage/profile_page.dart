import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/no_internet_page.dart';

import '../home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  File? file;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  bool isLoading = false;
  bool checkInternet = true;

  final maskFormatter = MaskTextInputFormatter(
    mask: "**-***-**-**",
    filter: {"*": RegExp(r"[0-9]")},
    type: MaskAutoCompletionType.lazy,
  );

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
    }
    autoFill();

    setState(() {});
  }

  void autoFill() async{
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneNumberController.text = user?.phoneNumber ?? '';
    userNameController.text = user?.username ?? '';
    passwordController.text = user?.password ?? '';
    dateOfBirthController.text = user?.dateOfBirth ?? '';
    file = File(user!.userImage.toString());

  }

  @override
  void initState(){
    super.initState();
    autoFill();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          // backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            // backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                // color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: const Text(
              "personal_information",
              style: TextStyle(
                // color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ).tr(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: Colors.blue.shade200),
                        child: file == null
                            ? const Icon(
                                Icons.add,
                                size: 60,
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: user!.userImage ?? 'https://w7.pngwing.com/pngs/188/501/png-transparent-computer-icons-anonymous-anonymity-anonymous-face-monochrome-head.png',
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// name
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "name".tr(),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// email
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: emailController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "email".tr(),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// phone
                  TextField(
                    controller: phoneNumberController,
                    maxLength: 12,
                    inputFormatters: [maskFormatter],
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 0.2)),
                      labelText: "phone_number".tr(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      counterText: "",
                      //prefix: Text('+998 '),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// username
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: userNameController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "username".tr(),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// password
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "password".tr(),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// birth
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: dateOfBirthController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "happy_birthday".tr(),
                        labelStyle: TextStyle(
                          // color: Colors.blue,
                          fontSize: 20,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// btn
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      checkInternet = await checkInternetConnection();

                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          phoneNumberController.text.trim().length < 12) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling")));
                      }
                      else {

                        if(checkInternet){

                          await DBService.updateUser(
                              emailController.text,
                              passwordController.text,
                              userNameController.text,
                              phoneNumberController.text,
                              nameController.text,
                              file!,
                              user?.favoriteUserUid ?? [],
                              dateOfBirthController.text);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Muvaffaqiyatli saqlandi")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        }
                        setState(() {
                          isLoading = false;
                        });

                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.sizeOf(context).width, 50),
                      ),
                    ),
                    child:  Text(
                      "save".tr(),
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if(isLoading)
          Center(child: CircularProgressIndicator.adaptive()),
        if(!checkInternet)
          NoInternetPage(function: (){},function1: (){},ctx: context,),
      ],
    );
  }
}
