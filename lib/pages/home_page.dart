import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';
import 'package:saxovat/views/home_page/carousel.dart';
import 'package:saxovat/views/home_page/category_btn.dart';
import 'package:saxovat/views/home_page/charity_view.dart';
import 'package:saxovat/views/home_page/donation_view.dart';
import 'package:saxovat/views/home_page/drawer.dart';
import 'package:saxovat/views/home_page/homeAppBar.dart';
import 'package:saxovat/views/no_internet_page.dart';
import '../bloc/theme/theme_bloc.dart';
import '../models/user_model.dart';
import '../services/sharedPreferences.dart';
import 'charityPage/donation_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

User? user;
List allPostList = [];
final List<Charity> donationList = [];
final List<Charity> charityList = [];

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool isInternetConnected = true;

  void getList() async {
    setState(() => isLoading = true);
    donationList.clear();
    charityList.clear();
    allPostList.clear();
    user = await DBService.readUserList(Auth.auth.currentUser!.uid);

    allPostList = await DBService.readPost();

    for (int i = 0; i < allPostList.length; i++) {
      if (allPostList[i].category == 'Xayriya') {
        if (!donationList.contains(allPostList[i])) {
          donationList.add(allPostList[i]);
        }
      }
      if (allPostList[i].category == 'Hashar') {
        if (!charityList.contains(allPostList[i])) {
          charityList.add(allPostList[i]);
        }
      }
    }
    setState(() => isLoading = false);
  }

  @override
  void didChangeDependencies() {
    getList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    checkInternetConnection();
    getInfo();
    super.initState();
  }

  void getInfo() async {
    bool isDark = await ModeAndLocalization.readFromSharedPref('isDark', bool);
    context.read<ThemeBloc>().add(ThemeChanged(isDark));
  }

  Future<void> checkInternetConnection() async {
    try {
      Uri url = Uri.https('google.com');
      final response = await http.get(url);
      setState(() {
        isInternetConnected = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        isInternetConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getList();
        checkInternetConnection();
      },
      child: Stack(
        children: [
          Scaffold(
            //  backgroundColor: Colors.white.withOpacity(0.95),
            appBar:
                PreferredSize(preferredSize: Size(50, 50), child: HomeAppBar()),
            drawer: HomeDrawer(),
            body: FutureBuilder<List<Charity>>(
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(child: CircularProgressIndicator.adaptive());
                // } else
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          CarouselCard(),
                          Text('category', style: font(size: 20)).tr(),
                          const SizedBox(height: 20),
                          const CategorySelectBtn(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('donation', style: font(size: 20)).tr(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DonationPage(
                                        category: 'Xayriya',
                                      ),
                                    ),
                                  );
                                },
                                child:  Text(
                                  'all',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ).tr(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          DonationView(donationList: donationList),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('charity', style: font(size: 20)).tr(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DonationPage(
                                        category: 'Hashar',
                                      ),
                                    ),
                                  );
                                },
                                child:  Text(
                                  'all',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ).tr(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CharityView(charityList2: charityList),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text('');
                }
              },
              future: DBService.readAllPost(),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.transparent,
              ),
            ),
          if (!isInternetConnected)
            NoInternetPage(
              function: getList,
              function1: checkInternetConnection,
              ctx: context,
            )
        ],
      ),
    );
  }
}
