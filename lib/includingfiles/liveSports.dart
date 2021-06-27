import 'package:flutter/material.dart';
import 'dart:convert';
import '../DBData/sportsgame.dart';
import 'package:http/http.dart' as http;

class Sports extends StatefulWidget {
  Sports({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Sports createState() => _Sports();
}
class _Sports extends State<Sports> {
  List _data = [];
  late int cnt = 0;
  var url = Uri.parse(
      'http://10.0.2.2:80/DaltonNetworkNews/flutterConn/sportsNewsLive.php');

  _fetchNews() {
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        for (int i = 0; i < news.length; i++) {
          var nnews = news[i];
          Sportss showNews = Sportss(
            nnews['id'],
            nnews['Home'],
            nnews['Guest'],
            nnews['HomeScore'],
            nnews['GuestScore'],
            nnews['status'],
            nnews['liveLink'],
            nnews['title'],
          );
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
    _fetchNews();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Dalton Network",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.50)),
        ),
      ),
      body: ListView.builder(
        itemCount: cnt,
        itemBuilder: (context, index) {
          Sportss showing = _data[index];
          if (showing.status == "live") {
            return Container(
              width: 0,
              height: 300,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 3,
                  )),
              child: InkWell(
                onTap: () {
                  print('Live Card tapped.');
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        showing.home + " VS " + showing.guest,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade600,
                        ),
                      ),
                      Text(
                        "\n" +
                            showing.homeScore +
                            " : " +
                            showing.guestScore +
                            "\n",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            "Live Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Card(
              child: InkWell(
                onTap: () {
                  print('Card tapped.');
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32, bottom: 32, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        showing.home + " VS " + showing.guest,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        showing.homeScore + " : " + showing.guestScore,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}