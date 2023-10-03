import 'package:flutter/material.dart';
import 'package:saxovat/views/font.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Tizimga kirish',
          style: font(color: Colors.white, size: 24, weight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(


        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 2,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(130),
                bottomRight: Radius.circular(130),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Text(
                    'S',
                    style: font(size: 72, color: Colors.blue.shade800),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Badge(
                  backgroundColor: Colors.white,
                  child: Text(
                    '*',
                    style: font(size: 23, color: Colors.red),
                  ),
                ),
                Text('Telefon raqamini kiriting', style: font(size: 18)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: phoneController,
              onChanged: (value){
                if(value.length==2 || value.length==6 || value.length==9){
                  phoneController.text +='-';
                }

              },
              decoration: InputDecoration(
                prefix: Text('+998 '),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.blue.shade800, width: 2)),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.sizeOf(context).width / 1.1,
                    MediaQuery.sizeOf(context).width / 8),
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
            onPressed: () {},
            child: const Text(
              "Kirish",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
