import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saxovat/services/db_services.dart';

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

  void autoFill() {
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneNumberController.text = user?.phoneNumber ?? '';
    userNameController.text = user?.username ?? '';
    passwordController.text = user?.password ?? '';
    dateOfBirthController.text = user?.dateOfBirth ?? '';
    file = File(user!.userImage.toString());
  }

  @override
  void initState() {
    super.initState();
    autoFill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Shaxsiy ma'lumotlarim",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
                        : Image(
                            image: NetworkImage(user!.userImage ?? ''),
                            fit: BoxFit.cover,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Ism",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 0.2)),
                  labelText: "Telefon raqam",
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Parol",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Tug'ulgan kun",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    )),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneNumberController.text.trim().length < 12) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling")));
                  } else {
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
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.sizeOf(context).width, 50),
                  ),
                ),
                child: const Text(
                  "Saqlash",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
