import 'package:flutter/material.dart';

class LogginIn {
  String first;
  String last;
  String id;
  String graduationYear;
  String email;
  String school;
  String imageLink;

  LogginIn(this.id, this.graduationYear, this.email, this.first, this.last, this.school, this.imageLink);

  LogginIn.fromJson(Map<String, dynamic> json)
      : id = json['accountID'],
        graduationYear = json['graduationYear'],
        email = json['email'],
        first = json['first_name'],
        last = json['last_name'],
        school = json['last'],
      imageLink = json['imageLink'];


  Map<String, dynamic> toJson() => {
    'id' : id,
    'graduationYear': graduationYear,
    'email': email,
    'first': first,
    'last': last,
    'school': school,
    'imageLink': imageLink
  };

  void setFirst(String first){
    this.first = first;
  }
  void setLast(String last){
    this.last = last;
  }
  void setId(String id){
    this.id = id;
  }
  void setGraduationYear(String graduationYear){
    this.graduationYear = graduationYear;
  }
  void setEmail(String email){
    this.email = email;
  }
  void setSchool(String school){
    this.school = school;
  }
  void setImageLink(String imageLink){
    this.imageLink = imageLink;
  }
}