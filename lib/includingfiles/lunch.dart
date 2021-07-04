import 'package:apitesting/DBData/lunchMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../DBData/getNews.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'constant/const.dart';
import 'constant/constants.dart';
import 'openNews.dart';

class Lunch extends StatefulWidget {
  Lunch({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lunch createState() => _Lunch();
}

class _Lunch extends State<Lunch> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  bool go = false;
  List _data = [];
  List _data2 = [];
  List _data3 = [];
  List _data4 = [];
  List _data5 = [];
  List _dataInt = [];
  List _dataInt2 = [];
  List _dataInt3 = [];
  List _dataInt4 = [];
  List _dataInt5 = [];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  late int cnt = 0;
  var url = Uri.parse('https://cdsnet.kr/flutterConn/lunchMenu.php');

  _mondayLunch() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "2" && nnews["type"] == "Korean") {
            setState(() {
              _data.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
    go = true;
  }

  _tuesdayLunch() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "3" && nnews["type"] == "Korean") {
            setState(() {
              _data2.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _wedLunch() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "4" && nnews["type"] == "Korean") {
            setState(() {
              _data3.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _thursdayLunch() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "5" && nnews["type"] == "Korean") {
            setState(() {
              _data4.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _fridayLunch() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "6" && nnews["type"] == "Korean") {
            setState(() {
              _data5.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _mondayLunchInt() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "2" && nnews["type"] == "Intern") {
            setState(() {
              _dataInt.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _tuesdayLunchInt() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "3" && nnews["type"] == "Intern") {
            setState(() {
              _dataInt2.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _wedLunchInt() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "4" && nnews["type"] == "Intern") {
            setState(() {
              _dataInt3.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _thursdayLunchInt() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "5" && nnews["type"] == "Intern") {
            setState(() {
              _dataInt4.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  _fridayLunchInt() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          LunchMenu showNews = LunchMenu(
              nnews["id"], nnews['type'], nnews['date'], nnews["menu"]);
          if (nnews["dayofweeks"] == "6" && nnews["type"] == "Intern") {
            setState(() {
              _dataInt5.add(showNews);
            });
          }
        }
      } else {
        print('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    if (!go) {
      _mondayLunch();
      _tuesdayLunch();
      _wedLunch();
      _thursdayLunch();
      _fridayLunch();
      _mondayLunchInt();
      _tuesdayLunchInt();
      _wedLunchInt();
      _thursdayLunchInt();
      _fridayLunchInt();
    }

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              days[0],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              child: PageView(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            "Korean",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: _data.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _data[index];
                              return Text(
                                "  - " + showings.menu,
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(

                      children: <Widget>[
                          Text(
                            "International",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18
                            )
                          ),
                          ListView.builder(
                            itemCount: _dataInt.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _dataInt[index];
                              return Text(
                                showings.menu + " -  ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              days[1],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              child: PageView(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            "Korean",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: _data2.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _data2[index];
                              return Text(
                                "  - " + showings.menu,
                                style:
                                TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        children: <Widget>[
                          Text(
                              "International",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18
                              )
                          ),
                          ListView.builder(
                            itemCount: _dataInt2.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _dataInt2[index];
                              return Text(
                                showings.menu + " -  ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              days[2],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              child: PageView(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            "Korean",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: _data3.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _data3[index];
                              return Text(
                                "  - " + showings.menu,
                                style:
                                TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        children: <Widget>[
                          Text(
                              "International",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18
                              )
                          ),
                          ListView.builder(
                            itemCount: _dataInt3.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _dataInt3[index];
                              return Text(
                                showings.menu + " -  ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              days[3],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              child: PageView(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            "Korean",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: _data4.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _data4[index];
                              return Text(
                                "  - " + showings.menu,
                                style:
                                TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        children: <Widget>[
                          Text(
                              "International",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18
                              )
                          ),
                          ListView.builder(
                            itemCount: _dataInt4.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _dataInt4[index];
                              return Text(
                                showings.menu + " -  ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              days[4],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  left: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  right: BorderSide(width: 1.0, color: Colors.grey.shade300),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
                ),
              ),
              child: PageView(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            "Korean",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: _data5.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _data5[index];
                              return Text(
                                "  - " + showings.menu,
                                style:
                                TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: ListView(
                        children: <Widget>[
                          Text(
                              "International",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18
                              )
                          ),
                          ListView.builder(
                            itemCount: _dataInt5.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              LunchMenu showings = _dataInt5[index];
                              return Text(
                                showings.menu + " -  ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
