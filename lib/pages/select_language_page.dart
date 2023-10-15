import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/pages/about_project_page.dart';
import 'package:saxovat/views/font.dart';

class SelectLanguagePage extends StatefulWidget {
  SelectLanguagePage({Key? key}) : super(key: key);

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  String lang = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Выберите язык / Tilni tanlang / Choose language ',
            style: font(weight: FontWeight.w500, size: 26),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectLng(
                image: const AssetImage('assets/images/Flag_of_Uzbekistan.png'),
                text: "O'zbek tili",
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Radio(
                  value: 'uzb',
                  groupValue: lang,
                  onChanged: (value) {
                    print(value);
                    lang = value as String;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectLng(
                image: const AssetImage('assets/images/Flag_of_Russia.png'),
                text: "Русский язык",
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Radio(
                  value: 'rus',
                  groupValue: lang,
                  onChanged: (value) {
                    lang = value as String;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectLng(
                image: const AssetImage(
                    'assets/images/Flag_of_the_United_Kingdom.png'),
                text: "English language",
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Radio(
                  value: 'eng',
                  groupValue: lang,
                  onChanged: (value) {
                    lang = value as String;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                elevation: 0,
                mini: true,
                backgroundColor:
                    lang == "" ? Colors.blue.shade100 : Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutProjectPage(),
                    ),
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.navigate_next_sharp,
                  size: 24,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SelectLng extends StatelessWidget {
  SelectLng({Key? key, required this.image, required this.text})
      : super(key: key);
  AssetImage image;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            image: image,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: font(),
          ),
        ],
      ),
    );
  }
}
