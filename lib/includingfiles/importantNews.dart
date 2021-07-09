import 'package:flutter/material.dart';
import 'dart:convert';
import 'constant/const.dart';
import '../DBData/getNews.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'openNews.dart';


class ImpNews extends StatefulWidget {
  ImpNews({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ImpNews createState() => _ImpNews();
}

class _ImpNews extends State<ImpNews> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  List _data = [];
  List _data2 = [];
  List _data3 = [];
  List _data4 = [];
  late int cnt = 0;
  late int cnt2 = 0;
  late int cnt3 = 0;
  late int cnt4 = 0;
  var url = Uri.parse(
      'https://cdsnet.kr/flutterConn/importantToday.php');
  var url2 = Uri.parse(
      'https://cdsnet.kr/flutterConn/importantWeek.php');
  var url3 = Uri.parse(
      'https://cdsnet.kr/flutterConn/importantMonth.php');
  var url4 = Uri.parse(
      'https://cdsnet.kr/flutterConn/importantAll.php');

  _fetchTodayNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews = News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
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

  _fetchWeekNews() {
    http.get(url2).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews = News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
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

  _fetchMonthNews() {
    http.get(url3).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews = News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
          setState(() {
            _data3.add(showNews);
          });
        }
        cnt3 = news.length;
      } else {
        print('Error');
      }
    });
  }

  _fetchAllNews() {
    http.get(url4).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews = News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
          setState(() {
            _data4.add(showNews);
          });
        }
        cnt4 = news.length;
      } else {
        print('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchTodayNews();
    _fetchWeekNews();
    _fetchMonthNews();
    _fetchAllNews();
    return Scaffold(

      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.indigo,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text("Important", textAlign: TextAlign.center),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              background: Image.asset(
                'images/important.png',
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.15),
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                News showing = _data[index];
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                link =
                                    'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                        showing.id + "&user=" + showing.email;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => showNews(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Posted today',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            link =
                                'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                    showing.id + "&user=" + showing.email;
                          });
                          print(link);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showNews(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                showing.title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Posted today',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Posted by: ' + showing.email,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: cnt,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                News showing = _data2[index];
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Text(
                          'Past Week',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                link =
                                    'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                        showing.id + "&user=" + showing.email;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => showNews(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    showing.dates,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            link =
                                'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                    showing.id + "&user=" + showing.email;
                          });
                          print(link);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showNews(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                showing.title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                showing.dates,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Posted by: ' + showing.email,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: cnt2,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                News showing = _data3[index];
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Text(
                          'Past Month',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                link =
                                    'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                        showing.id + "&user=" + showing.email;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => showNews(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    showing.dates,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            link =
                                'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                    showing.id + "&user=" + showing.email;
                          });
                          print(link);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showNews(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                showing.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                showing.dates,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Posted by: ' + showing.email,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: cnt3,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                News showing = _data4[index];
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Text(
                          'More than a month ago',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                link =
                                    'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                        showing.id + "&user=" + showing.email;
                              });
                              print(link);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => showNews(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    showing.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    showing.dates,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Posted by: ' + showing.email,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            link =
                                'https://cdsnet.kr/flutterConn/mobile/openNews_mobile.php?id=' +
                                    showing.id + "&user=" + showing.email;
                          });
                          print(link);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showNews(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                showing.title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                showing.dates,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Posted by: ' + showing.email,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: cnt4,
            ),
          ),
        ],
      ),
    );
  }
}
