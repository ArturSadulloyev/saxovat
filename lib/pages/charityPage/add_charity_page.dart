import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Sarlavha",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    )),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(10),
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            dropdownColor: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15),
                            elevation: 5,
                            value: _myState,
                            iconSize: 30,
                            icon: (null),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: const Text('Tanlang'),
                            onChanged: (newValue) {
                              setState(() {
                                _myState = newValue ?? 'Xayriya';
                              });
                            },
                            items: statesList.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: font(
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                //keyboardType: TextInputType.text,
                controller: descriptionController,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Batafsil ma'lumot",
                    labelStyle: TextStyle(
                      color: Colors.blue,
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(width: 0.2)),
                          labelText: "Karta raqamini kiriting",
                          labelStyle: TextStyle(
                            color: Colors.blue,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 0.2)),
                    labelText: "Manzil",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    )),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      file!.path.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Muvaffaqiyatli saqlandi"),
                      ),
                    );

                    await DBService.storeCharity(
                      titleController.text,
                      descriptionController.text,
                      Auth.auth.currentUser!.uid,
                      _myState,
                      locationController.text,
                      cardNumBerController.text,
                      file!,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
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
              SizedBox(height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
