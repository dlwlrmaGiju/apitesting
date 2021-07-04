import "package:flutter/material.dart";

import 'calendars/fp.dart';
import 'calendars/hs.dart';
import 'calendars/ms.dart';
import 'calendars/year.dart';

class Dates extends StatelessWidget {
  double widthOfButton = 130;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Image.asset('images/calendar.png'),
          ),
          SizedBox(
            height: 35,
          ),
          SizedBox(
            width: widthOfButton,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue))),
              ),
              child: Text("First Program"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FP()),
                );
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: widthOfButton,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue))),
              ),
              child: Text("Middle School"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MS()),
                );
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: widthOfButton,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue))),
              ),
              child: Text("High School"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HS()),
                );
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: widthOfButton,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue))),
              ),
              child: Text("School Year"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Year()),
                );
              },
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
