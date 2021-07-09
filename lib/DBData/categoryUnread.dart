import 'package:flutter/material.dart';

class unreadCount {
  String important;
  String events;
  String all;
  String clubs;
  String wuw;
  String newsletter;


  unreadCount(this.important, this.events, this.all, this.clubs, this.wuw, this.newsletter);

  unreadCount.fromJson(Map<String, dynamic> json)
      : important = json['importantCnt'],
        events = json['eventCnt'],
        all = json['allcnt'],
        clubs = json['clubCnt'],
        wuw = json['wuwCnt'],
        newsletter = json['newsLetterCnt'];


  Map<String, dynamic> toJson() => {
    'important' : important,
    'events': events,
    'all': all,
    'clubs': clubs,
    'wuw': wuw,
    'newsletter': newsletter,
  };
}