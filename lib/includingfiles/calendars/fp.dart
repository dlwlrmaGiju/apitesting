import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FP extends StatefulWidget {
  @override
  _FPState createState() => _FPState();
}

class _FPState extends State<FP> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Program Calendar"),
        backgroundColor: Color(0xFF04103E),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://calendar.google.com/calendar/u/0/embed?src=daltonschool.kr_7so53sak57u6gfjopmcgdbvoh4@group.calendar.google.com&ctz=Asia/Seoul',
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
