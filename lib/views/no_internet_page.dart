import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'font.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage(
      {super.key, required this.function, this.function1, required this.ctx});

  Function function;
  Function? function1;
  BuildContext ctx;
  bool isInternet = false;

  // Future<void> checkInternetConnection() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          function();
          function1!() ?? function();
          isInternet = await checkInternetConnection();
          if (isInternet) {
            Navigator.pop(ctx);
          }
        },
        child: Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/lotties/Animation - 1701343781547.json',
                height: 300, width: 300),
            Text(
              'No Internet Connection',
              style: font(size: 18, weight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Text(
              'Please check your connection and try again',
              style:
                  font(size: 16, color: Colors.grey, weight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkInternetConnection() async {
  try {
    Uri url = Uri.https('google.com');
    final response = await http.get(url);
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
