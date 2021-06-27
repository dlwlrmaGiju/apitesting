import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constant/constants.dart';
import 'package:flutter/cupertino.dart';
import '../homepage/../../DBData/homepagenews.dart';


class AllTabView extends StatefulWidget {
  @override
  _AllTabViewState createState() => _AllTabViewState();
}

class _AllTabViewState extends State<AllTabView> {
  List _data = [];
  List _data2 = [];
  late int cnt = 0;
  late int cnt2 = 0;
  var url = Uri.parse('https://cdsnet.kr/flutterConn/homenews.php');
  var url2 = Uri.parse('https://cdsnet.kr/flutterConn/homenews_important.php');
  _fetchTodayNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          HomeNews showNews =
          HomeNews(nnews["title"], nnews['email'], nnews['dates'], nnews["id"], nnews["images"], nnews["caption"]);
          setState(() {
            _data.add(showNews);
          });
        }
        cnt = news.length;
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
          HomeNews showNews =
          HomeNews(nnews["title"], nnews['email'], nnews['dates'], nnews["id"], nnews["images"], nnews["caption"]);
          setState(() {
            _data2.add(showNews);
          });
        }
        cnt2 = news.length;
      } else {
        print('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      _fetchTodayNews();
      _fetchTodayNews2();
    }
    return Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 3),

            SizedBox(height: 15),

            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.only(left: 18),
              child: ListView.builder(
                itemCount: _data2.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  HomeNews showing = _data2[index];
                  return InkWell(
                    onTap: () {
                      //put it later
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Container(
                        width: 300.0,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                                Text(showing.email, style: kCategoryTitle)
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
                              style: kTitleCard,
                            ),
                            Text(
                              showing.caption,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: kDetailContent,
                            ),
                            SizedBox(height: 5.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(showing.dates, style: TextStyle(color: Colors.grey[500])),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
              itemCount: _data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                HomeNews showing = _data[index];
                return InkWell(
                  onTap: () {

                  },
                  child: Container(
                    width: double.infinity,
                    height: 115.0,
                    margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                                    style: kTitleCard,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    showing.caption,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: kDetailContent,
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(showing.dates, style: TextStyle(color: Colors.grey[500])),
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
  }
}