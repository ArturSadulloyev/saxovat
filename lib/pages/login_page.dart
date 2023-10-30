import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/pages/phone_auth_page.dart';
import 'package:saxovat/pages/sign_up_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/views/font.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final maskFormatter = MaskTextInputFormatter(
  //   mask: "****-**-***-**-**",
  //   filter: {"*": RegExp(r"$[+][0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}[0-9]{2}")},
  //   type: MaskAutoCompletionType.lazy,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Tizimga kirish',
          style: font(color: Colors.white, size: 24, weight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 2.8,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(180),
                  bottomRight: Radius.circular(180),
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
            const SizedBox(
              height: 50,
            ),
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
                  Text('Email kiriting', style: font(size: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 5, bottom: 20),
              child: TextField(
                // inputFormatters: [maskFormatter],
                controller: emailController,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.blue.shade800, width: 2),
                  ),
                ),
              ),
            ),
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
                  Text('Parol kiriting', style: font(size: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 5, bottom: 20),
              child: TextField(
                // inputFormatters: [maskFormatter],
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.blue.shade800, width: 2),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: Text("Ro'yhatdan o'tish"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.sizeOf(context).width / 1.1,
                      MediaQuery.sizeOf(context).width / 7),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue.shade800),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                final result = await Auth.signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );
                print('result11111111111w1222222222222222222222222222222222222221111111111111111111111111 $result');
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
                      content: Text('Login yoki parol xato'),
                    ),
                  );
                }
              },
              child: const Text(
                "Kirish",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
