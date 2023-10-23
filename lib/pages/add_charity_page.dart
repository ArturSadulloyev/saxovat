import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/database_service.dart';
import 'package:saxovat/views/font.dart';

class AddCharityPage extends StatefulWidget {
  const AddCharityPage({super.key});

  @override
  State<AddCharityPage> createState() => _AddCharityPageState();
}

class _AddCharityPageState extends State<AddCharityPage> {
  final ImagePicker picker = ImagePicker();
  String dropdownValue = 'Dog';
  File? file;
  var items = ['top0', 'top1'];
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController locationController = TextEditingController();

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

  String _myState = 'Xayriya';
  var statesList = ['Xayriya', 'Volontyorlik'];

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
                            items: statesList?.map((item) {
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
                                })?.toList() ??
                                [],
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
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      locationController.text.trim().length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Muvaffaqiyatli saqlandi")));
                    Charity charity = Charity(
                        id: '0',
                        title: titleController.text,
                        description: descriptionController.text,
                        userId: '2',
                        category: _myState,
                        location: locationController.text,
                        imageUrl: [file.toString()],
                        createdAt: DateTime.now(),
                        comments: []);
                    /// #TODO
                    charityList.add(charity);

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
