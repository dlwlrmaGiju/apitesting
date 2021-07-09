import 'package:apitesting/DBData/getLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
String link = 'hello';
String newsletterlink = 'notihng';
String wuw = 'notihng';
bool opened = false;
String email = 'nothing';
String password = 'nothing';
List<String> readNews = []; //stores which news are read
String UserEmail = 'noData'; //Stores the user's email on the phone so you can automatically login later
int went = 0;
var urlForHomeNews;
bool justBooted = true;//to see if the app just opened or not
LogginIn userInfo = LogginIn("id", "graduationYear", "email", "first", "last", "school", "imageLink") ;
var loggedIn =false;
var urls = Uri.parse(
    'nothing');
var homeNewsList;
