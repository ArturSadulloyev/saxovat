import 'package:flutter/material.dart';
import 'package:saxovat/views/font.dart';

import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 20),
                Text(
                  'SAXOVAT',
                  style: font(size: 36, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.sizeOf(context).width / 1.2,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text(
              "Tizimga kirish",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
