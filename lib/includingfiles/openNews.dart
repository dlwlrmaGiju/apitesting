// @dart=2.9
import 'dart:convert';

import 'package:apitesting/DBData/homepagenews.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'constant/const.dart';
import 'package:http/http.dart' as http;

class showNews extends StatelessWidget {

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SafeArea(

        child: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
          );
        }),
      ),
    );
  }
}
//you here now?

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
    name: 'Toaster',
    onMessageReceived: (JavascriptMessage message) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message.message)),
      );
    },
  );
}
