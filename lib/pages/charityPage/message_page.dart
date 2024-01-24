import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/message_model.dart';
import 'package:saxovat/pages/charityPage/comment_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Message> msgList = [];
  List<Charity> charityList = [];
  List<Charity> charityList2 = [];
  bool isLoading = false;
  List<Charity> searchResults = [];

  void findMessage() async {
    setState(() {
      isLoading = true;
    });
    msgList = await DBService.readAllMessage(Auth.auth.currentUser!.uid);

    setState(() {
      isLoading = false;
    });
  }

  void findCharity() async {
    List<Charity> charList = await DBService.readAllPost();
    final msgList2 = await DBService.readAllMessage(Auth.auth.currentUser!.uid);
    Set<Charity> setCharity = {};
    Set<Message> setMsg = {};
    for (int i = 0; i < charList.length; i++) {
      for (int j = 0; j < msgList2.length; j++) {
        if (charList[i].id == msgList2[j].id) {
          setCharity.add(charList[i]);
          setMsg.add(msgList2[j]);
        }
      }
    }
    charityList = setCharity.toList();
    charityList2 = setCharity.toList();
    msgList = setMsg.toList();
    setState(() {
      isLoading = false;
    });
  }

  void onSearchTextChanged(String searchText) {
    searchResults.clear();

    if (searchText.isEmpty) {
      findCharity();

      setState(() {});
      return;
    }

    charityList2.forEach((item) {
      if (item.title.toLowerCase().contains(searchText.toLowerCase())) {
        searchResults.add(item);
      }
    });

    if ((searchResults.isEmpty && searchText.isNotEmpty)) {
      charityList = searchResults;
    }

    if (searchText.isNotEmpty) {
      charityList = searchResults;
    }

    setState(() {});
  }

  @override
  void initState() {
    findMessage();
    findCharity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Xabarlar',
              style: font(
                size: 22,
                color: Colors.red,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: SingleChildScrollView(
            // primary: true,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 20),
                // MySearchTextField2(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.35),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: onSearchTextChanged,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: charityList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        int id = 1;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentPage(
                                  msg: msgList[id],
                                  charity: charityList[index])),
                        );
                      },
                      child: Card(
                        elevation: 6,
                        margin: EdgeInsets.all(10),
                        child: Container(
                          height: 250,
                          width: 150,
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: charityList[index].imageUrl,
                                  height: 100,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  charityList[index].title,
                                  style: font(
                                      size: 15,
                                      color: Colors.black,
                                      weight: FontWeight.w400),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 90,
                                margin: const EdgeInsets.all(3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  charityList[index].category,
                                  style: font(size: 14),
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Text(
                                  charityList[index].location,
                                  style: font(size: 14),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.87),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent,
            ),
          ),
      ],
    );
  }
}

class MySearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class MySearchTextField2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        ),
      ),
    );
  }
}

class MySearchPage extends StatefulWidget {
  List dataList = [];

  MySearchPage({required this.dataList});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: searchResults.isNotEmpty
              ? ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchResults[index]),
                      // Add onTap functionality or any other customizations here
                    );
                  },
                )
              : Center(
                  child: Text('No results found'),
                ),
        ),
      ],
    );
  }

  void onSearchTextChanged(String searchText) {
    searchResults.clear();
    if (searchText.isEmpty) {
      setState(() {});
      return;
    }

    widget.dataList.forEach((item) {
      if (item.toLowerCase().contains(searchText.toLowerCase())) {
        searchResults.add(item);
      }
    });

    setState(() {});
  }
}
