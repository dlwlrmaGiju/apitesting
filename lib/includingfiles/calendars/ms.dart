import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MS extends StatefulWidget {
  @override
  _MSState createState() => _MSState();
}

class _MSState extends State<MS> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Middle School Calendar"),
        backgroundColor: Color(0xFF04103E),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://calendar.google.com/calendar/u/0/embed?src=daltonschool.kr_i3pg3ggmscinlfpmnn3r931e3k@group.calendar.google.com&ctz=Asia/Seoul',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xFF04103E)),
                )
              : Stack(),
        ],
      ),
    );
  }

}
