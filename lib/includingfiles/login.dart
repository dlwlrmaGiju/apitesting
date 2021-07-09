import 'dart:io';

import 'package:apitesting/DBData/getLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'constant/const.dart';
import 'dart:convert';
import '../DBData/getNews.dart';
import 'package:http/http.dart' as http;

// Define a custom Form widget.
class Login extends StatefulWidget {
  @override
  _Login createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailIn = new TextEditingController();
  TextEditingController passwordIn = new TextEditingController();

  _logInGood() {
    http.get(urls).then((response) {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List news = jsonDecode(jsonString);
        var nnews = news[0];

        LogginIn info = LogginIn(
            nnews["accountID"],
            nnews['graduationYear'],
            nnews['email'],
            nnews["first_name"],
            nnews["last_name"],
            nnews["school"],
            nnews["imageLink"]);
        setState(() {
          userInfo = new LogginIn(info.id, info.graduationYear, info.email,
              info.first, info.last, info.school, info.imageLink);
        });
        print(userInfo.last);
      } else {
        print('Error');
      }
    });
  }

  bool logInCheck() {
    _logInGood();
    if (userInfo != null) {
      return true;
    } else {
      return false;
    }
  }

  Stopwatch s = new Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Login to get the most out of Dalton Network',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: emailIn,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You need to fill this part';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: passwordIn,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You need to fill this part';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    email = emailIn.text;
                    password = passwordIn.text;
                    urls = Uri.parse(
                        'https://cdsnet.kr/flutterConn/mobile/loginProcess_m.php?id=' +
                            email +
                            '-' +
                            password);
                    _logInGood();
                    Future.delayed(Duration(milliseconds: 800), () async {
                      if (userInfo.first != "first") {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('UserMail', userInfo.email);
                        print(UserEmail);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Access denied'),
                            content: const Text(
                                'Hmmm.. the password/email you entered is invalid. If you wish to create an account, go to cdsnet.kr'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
