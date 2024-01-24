import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/network.dart';
import 'package:saxovat/views/font.dart';
import '../../services/db_services.dart';
import '../../views/no_internet_page.dart';
import '../home_page.dart';

class DeleteEditCharityPage extends StatefulWidget {
  DeleteEditCharityPage({super.key, required this.charity});

  Charity charity;

  @override
  State<DeleteEditCharityPage> createState() => _DeleteEditCharityPageState();
}

class _DeleteEditCharityPageState extends State<DeleteEditCharityPage> {
  final ImagePicker picker = ImagePicker();

  File? file;

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  void autoFill() {
    titleController.text = widget.charity?.title ?? '';
    contentController.text = widget.charity?.description ?? '';
    locationController.text = widget.charity?.location ?? '';
    cardNumberController.text = widget.charity?.cardNumber ?? '';
    categoryController.text = widget.charity?.category ?? '';
    file = File(widget.charity?.imageUrl ?? '');
  }

  bool isInternetConnected = true;
  bool isLoading = false;

  @override
  void initState() {
    autoFill();
    super.initState();
  }

  void getImage() async {
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Loyihani tahrirlash',
              style:
                  font(color: Colors.black, size: 22, weight: FontWeight.w700),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
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
                            : Image(
                                image:
                                    NetworkImage(widget.charity.imageUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// title
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
                  const SizedBox(height: 20),

                  /// content
                  TextField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    controller: contentController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(width: 0.2)),
                        labelText: "Batafsil malumot",
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        )),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 20),

                  /// location
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(width: 0.2)),
                      labelText: "Manzil",
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
                  const SizedBox(height: 20),

                  /// cardNumber
                  widget.charity.cardNumber!.isEmpty
                      ? SizedBox.shrink()
                      : TextField(
                          keyboardType: TextInputType.text,
                          controller: cardNumberController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(width: 0.2)),
                              labelText: "Karta raqami",
                              labelStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),

                  widget.charity.cardNumber!.isEmpty
                      ? SizedBox.shrink()
                      : SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          contentController.text.isEmpty ||
                          locationController.text.trim().length < 4) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Saqlashdan oldin ma'lumotlar to'g'ri kiritilganiga amin bo'ling"),
                          ),
                        );
                      } else {
                        // final imgUrl = await StoreService.uploadFile(file!);
                        setState(() {
                          isLoading = true;
                        });
                        isInternetConnected = await checkInternetConnection();
                        if (isInternetConnected) {

                          Map<String, Object> data = {
                            "title": titleController.text,
                            "content": contentController.text,
                            "category": categoryController.text,
                            "location": locationController.text,
                            "cardNumber": cardNumberController.text,
                            "createdAt": DateTime.now().toString(),
                          };
                          await Network.methodPut(
                            api: Network.apiCharity,
                            id: widget.charity.id,
                            data: data,
                          );



                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Ma'lumotlar yangilandi")));
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
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.sizeOf(context).width, 50),
                      ),
                    ),
                    child: const Text(
                      "Yangilash",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        if (!isInternetConnected)
          NoInternetPage(
            function: () {},
            function1: () {},
            ctx: context,
          )
      ],
    );
  }
}
