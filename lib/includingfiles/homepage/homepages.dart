import 'package:apitesting/DBData/lunchMenu.dart';
import 'package:apitesting/includingfiles/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../main.dart';
import '../NewsLetter.dart';
import '../constant/constants.dart';
import 'package:flutter/cupertino.dart';
import '../homepage/../../DBData/homepagenews.dart';
import '../openNews.dart';

class AllTabView extends StatefulWidget {
  @override
  _AllTabViewState createState() => _AllTabViewState();
}

class _AllTabViewState extends State<AllTabView> {
  List _data = [];
  List _data2 = [];
  List _data3 = [];
  List _data4 = [];
  bool go = false;
  late int cnt = 0;
  late int cnt2 = 0;
  late int cnt3 = 0;
  late int cnt4 = 0;
  var url = Uri.parse('https://cdsnet.kr/flutterConn/homenews.php');
  var url2 = Uri.parse('https://cdsnet.kr/flutterConn/homenews_important.php');
  var url3 = Uri.parse('https://cdsnet.kr/flutterConn/lunchMenu_Today.php');

  _fetchTodayNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          HomeNews showNews = HomeNews(
              nnews["title"],
              nnews['email'],
              nnews['dates'],
              nnews["id"],
              nnews["images"],
              nnews["caption"],
              nnews["category"]);
          setState(() {
            _data.add(showNews);
            go = true;
          });
        }
        if(go){
          cnt = news.length;
          go = false;
        }
      } else {
        print('Error');
      }
    });
  }

  _fetchTodayNews2() {
    http.get(url2).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          HomeNews showNews = HomeNews(
              nnews["title"],
              nnews['email'],
              nnews['dates'],
              nnews["id"],
              nnews["images"],
              nnews["caption"],
              nnews["category"]);
          setState(() {
            _data2.add(showNews);
            go = true;
          });
        }
        if(go){
          cnt2 = news.length;
          go = false;
        }
      } else {
        print('Error');
      }
    });
  }

  _getLunchKorean() {
    http.get(url3).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews["type"], nnews["date"], nnews["menu"]);
          if (showNews.type == "Korean") {
            setState(() {
              _data3.add(showNews);
              go = true;
            });
          }
        }
        if(go){
          cnt3 = news.length;
          go = false;
        }
      } else {
        print('Error');
      }
    });
  }

  _getLunchIntern() {
    http.get(url3).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews["type"], nnews["date"], nnews["menu"]);
          if (showNews.type == "Intern") {
            setState(() {
              _data4.add(showNews);
              go = true;
            });
          }
        }
        if(go){
          cnt4 = news.length;
          go = false;
        }
      } else {
        print('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    if (cnt <= 0) {
      _fetchTodayNews();
      _fetchTodayNews2();
      _getLunchKorean();
      _getLunchIntern();
    }
    return Container(
        child: ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 3),
        SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          width: double.infinity,
          height: 200,
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage('images/lunchBackground.jpg'),
                      fit: BoxFit.cover),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.black.withOpacity(.2),
                      Colors.black.withOpacity(.1),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "Korean",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.marckScript(
                            textStyle:
                                TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                          itemCount: cnt3,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            LunchMenu showings = _data3[index];
                            return Text(
                              "  - " + showings.menu,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage('images/lunchBackground2.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 10),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "International",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.marckScript(
                            textStyle:
                                TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                          itemCount: cnt4,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            LunchMenu showings = _data4[index];
                            return Text(
                              showings.menu + " -   ",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Recent Important Posts", style: kNonActiveTabStyle),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.only(left: 18),
          child: ListView.builder(
            itemCount: cnt2,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              HomeNews showing = _data2[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    link =
                        'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                            showing.id;
                  });
                  print(link);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => showNews(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Container(
                    width: 300.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: kGrey3, width: 1.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor: kGrey1,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              showing.email,
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Expanded(
                          child: Hero(
                            tag: showing.title,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  image: NetworkImage(showing.images),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          showing.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          showing.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(showing.dates,
                              style: TextStyle(color: Colors.grey[500])),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height:25),

        Container(
          child: ElevatedButton(
            onPressed: showNotification,
            child: Text("notif"),
          )
        ),


        SizedBox(height: 25),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Recent Posts", style: kNonActiveTabStyle),
          ),
        ),
        ListView.builder(
          itemCount: cnt,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            HomeNews showing = _data[index];
            return InkWell(
              onTap: () {
                if (showing.category == "Newsletter") {
                  setState(() {
                    newsletterlink =
                        'https://cdsnet.kr/newsletter.php?id=' + showing.id;
                  });
                  print(newsletterlink);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsLetter(),
                    ),
                  );
                } else if (showing.category == "WUW") {
                  setState(() {
                    newsletterlink =
                        'https://cdsnet.kr/newsletter.php?id=' + showing.id;
                  });
                  print(newsletterlink);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsLetter(),
                    ),
                  );
                } else {
                  setState(() {
                    link =
                        'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                            showing.id;
                  });
                  print(link);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => showNews(),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 115.0,
                margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: kGrey3, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 90.0,
                        height: 135.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(showing.images),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                showing.title,

                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                showing.caption,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(showing.dates,
                                    style: TextStyle(color: Colors.grey[500])),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 15),
      ],
    ));
    _data.clear();
    _data2.clear();
    _data3.clear();
    _data4.clear();
  }

  void showNotification() {
    print("Hello");
    flutterLocalNotificationsPlugin.show(
        0,

        "New post",
        "Check out the new event that was just posted!",


        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: "@mipmap/ic_launcher"),
        ));
  }

}
