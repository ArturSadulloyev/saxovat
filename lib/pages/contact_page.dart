import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Future<void>? _launched;
  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch1 =
        Uri(scheme: 'https', host: 'www.youtube.com', path: '@MehrliQollar');
    final Uri toLaunch2 =
        Uri(scheme: 'https', host: 't.me', path: 'Mehrliqollar');
    Uri url = Uri(scheme: "tel", path: "+998888666621");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Biz bilan aloqa",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _launched = _launchInWebViewOrVC(toLaunch2);
                    }),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.telegram,
                          size: 60,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Telegram",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _launched = _launchInWebViewOrVC(toLaunch1);
                    }),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                            clipBehavior: Clip.antiAlias,
                            height: 45,
                            width: 56,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Image.asset(
                              "assets/images/you_tube.png",
                              height: 62,
                              width: 62,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "You tube",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.platformDefault);
                      }
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.phone_android,
                          size: 60,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "+998-88-866-66-21",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Bizga yozing!",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 270,
              child: Stack(
                children: [
                  TextField(
                    controller: controller,
                    maxLines: 15,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: "Yozing...",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade700, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            controller.clear();
                          },
                          child: const Icon(Icons.send),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
