import 'package:flutter/material.dart';
import 'dart:convert';
import '../DBData/getNews.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'constant/const.dart';
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
  List _data = [];

  late int cnt = 0;
  var url = Uri.parse('https://cdsnet.kr/flutterConn/eventNewsToday.php');

  _fetchTodayNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          News showNews =
              News(nnews["title"], nnews['email'], nnews['dates'], nnews["id"]);
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

  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      _fetchTodayNews();
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/lunchBackground.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Text(
              "Today's Lunch",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
