import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  File? file;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: "**-***-**-**",
    filter: {"*": RegExp(r"[0-9]")},
    type: MaskAutoCompletionType.lazy,
  );

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      setState(() {});
    }
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
              const SizedBox(
                height: 50,
              ),
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
                        : Image.file(
                            file!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Ismingiz",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    )),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.text,
                controller: surnameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Familiyangiz",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    )),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(height: 40),
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
                  prefix: Text('+998 '),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      surnameController.text.isEmpty ||
                      phoneNumberController.text.trim().length < 12) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Muvaffaqiyatli saqlandi")));
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
