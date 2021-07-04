import 'package:apitesting/includingfiles/Clubs.dart';
import 'package:apitesting/includingfiles/allNews.dart';
import 'package:flutter/material.dart';
import 'NewsLetter.dart';
import 'eventNews.dart';
import 'whatsupwed.dart';
import 'liveSports.dart';

class Athletics extends StatefulWidget {
  @override
  _Athletics createState() => _Athletics();
}

class _Athletics extends State<Athletics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 15.0, right: 15.0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sports(
                            title: 'sup',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('images/athletics2.png'),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Athletics",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 30, left: 20.0, right: 20.0),
                ),
              ],
            ),
          ),
        ));
  }
}
