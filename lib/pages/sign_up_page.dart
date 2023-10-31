import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saxovat/pages/home_page.dart';
import '../services/auth_service.dart';
import '../services/db_services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final ImagePicker picker = ImagePicker();
  File? file;

  TextEditingController birthController = TextEditingController();

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      setState(() {});
    }
  }

  void getUser(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// image picker
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: getImage,
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
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
          SizedBox(height: 50),

          /// name
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: nameController,
              decoration: InputDecoration(
                label: Text('Ismingizni kiriting'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// email
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email kiriting'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// phone
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: phoneController,
              decoration: InputDecoration(
                label: Text('Telefon raqami kiriting'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// username
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: usernameController,
              decoration: InputDecoration(
                label: Text('Username kiriting'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// password
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: passwordController,
              decoration: InputDecoration(
                label: Text('Parol kiriting'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// birth
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              // inputFormatters: [maskFormatter],
              controller: birthController,
              decoration: InputDecoration(
                labelText: "Tug'ulgan kuningizni kiriting",
                suffixIcon: IconButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate, // Refer step 1
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );

                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                    birthController.text =
                        selectedDate.day.toString().padLeft(2, '0') +
                            '/' +
                            selectedDate.month.toString().padLeft(2, '0') +
                            '/' +
                            selectedDate.year.toString();
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                ),
              ),
            ),
          ),

          /// btn
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.sizeOf(context).width / 1.1,
                    MediaQuery.sizeOf(context).width / 7),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.blue.shade800),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            onPressed: () async {
              /// # TODO

              final result = await Auth.createUserWithEmailAndPassword(
                emailController.text,
                passwordController.text,
                usernameController.text,
                phoneController.text,
                nameController.text,
                file!,
                [],
                birthController.text,
              );
              await CircularProgressIndicator.adaptive();

              if (result) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Iltimos qayta urinib ko'ring !"),
                  ),
                );
              }
            },
            child: const Text(
              "Ro'yhatdan O'tish",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],

      ),
    );
  }
}
