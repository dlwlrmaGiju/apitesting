import "package:flutter/material.dart";
import 'package:pinch_zoom/pinch_zoom.dart';

class Year extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School Year Calendar"),
        backgroundColor: Color(0xFF04103E),
      ),
      body: PinchZoom(
        image: Image.asset('images/year.png'),
        zoomedBackgroundColor: Colors.white,
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 10,
      ),
    );
  }
}