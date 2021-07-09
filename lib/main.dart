// @dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:apitesting/includingfiles/documents/privacy.dart';
import 'package:apitesting/includingfiles/documents/terms.dart';
import 'package:apitesting/version.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DBData/getLogin.dart';
import 'includingfiles/Dates.dart';
import 'includingfiles/constant/const.dart';
import 'includingfiles/constant/constants.dart';
import 'includingfiles/categories.dart';
import 'includingfiles/homepage/homepages.dart';
import 'includingfiles/liveSports.dart';
import 'includingfiles/login.dart';
import 'includingfiles/lunch.dart';
import 'package:mailto/mailto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  "This channel is used for important notifications",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A message just showed up pog: " + message.messageId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void initState() {
    super.initState();

    _fcm.getToken().then((token) {
      print("The token is: " + token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            //HERE PUT CUSTUM STUFF
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: null,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp event");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final fontColor = Colors.grey[700];




  @override
  void initState() {
    getEmail();
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      UserEmail = prefs.getString('UserMail');
    });
  }
  var autoLogInUrl;

  _logInGood() {
    http.get(autoLogInUrl).then((response) {
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
        print('ErrorhasOccured');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    urlForHomeNews =
        Uri.parse('https://cdsnet.kr/flutterConn/homenews.php?id=' + UserEmail);
    if (UserEmail != "noData" && justBooted) {
      print(urlForHomeNews);
      //autologin
      setState(() {
        autoLogInUrl = Uri.parse(
            'https://cdsnet.kr/flutterConn/mobile/autoLogin.php?id=' + UserEmail);
      });
      print(autoLogInUrl);
      _logInGood();
      went++;
      loggedIn = true;
      justBooted = false;
    }

    if (went <= 0) {
      if (userInfo.graduationYear != "graduationYear") {
        setState(() {
          loggedIn = true;
        });
      } else {
        loggedIn = false;
      }
    }
    print(loggedIn);
    went = 0;
    return new WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: [
                loggedIn
                    ?
                //LOGGED IN
                Container(
                  height: 340,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700.withOpacity(0.5),
                          spreadRadius: 8,
                          blurRadius: 15,
                          offset: Offset(
                              0, 0.75), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: new DecorationImage(
                        image: NetworkImage(userInfo.imageLink),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7),
                            BlendMode.srcOver),
                        fit: BoxFit.cover,
                      ),
                    ),
                    currentAccountPictureSize: Size.square(130),
                    currentAccountPicture: Container(
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: const Color(0xFF77889),
                        backgroundImage: NetworkImage(userInfo.imageLink),
                      ),
                    ),
                    accountName: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              userInfo.first + " " + userInfo.last,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23),
                            ),
                            userInfo.graduationYear != "graduationYear"
                                ? Text(
                              " " + userInfo.graduationYear,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11),
                            )
                                : Text(
                              " Teacher",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11),
                            )
                          ],
                        )),
                    accountEmail: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Container(
                        child: Text(
                          userInfo.email,
                          style: TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                )
                    :

                //NOT LOGGED IN
                Container(
                  height: 220,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage('images/cds.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: null,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.mail),
                        title: Text(
                          'Contact',
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 18,
                          ),
                        ),
                        onTap: launchMailto,
                      ),

                      ListTile(
                        leading: Icon(Icons.contact_page),
                        title: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Terms()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.shield),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()),
                          );
                        },
                      ),
                      //LOGIN: CHANGES LOGIN TO LOGOUT WHEN LOGGED IN AND SO ON YOU GET THE IDEA
                      //CONTROLLED BY BOOLEAN ABOVE CALLED loggedIn
                      ListTile(
                        leading:
                        loggedIn ? Icon(Icons.logout) : Icon(Icons.login),
                        title: Text(
                          loggedIn ? 'Log Out' : 'Log In',
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () async {
                          //log out of account function
                          print("Logged out!");
                          loggedIn
                              ? logOutBoolean()
                              : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                          logInBoolean();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Text(
                          "Version " + version,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        icon: Icon(Icons.menu)),
                    Expanded(
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: kGrey1,
                        unselectedLabelStyle: kNonActiveTabStyle,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                        tabs: [
                          Tab(text: "All"),
                          Tab(text: "Category"),
                          Tab(text: "Lunch"),
                          Tab(text: "Dates"),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: TabBarView(
            children: [AllTabView(), Cate(), Lunch(), Dates()],
          ),
        ),
      ),
    );
  }
  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['wooseokshin2023@daltonschool.kr', 'gkim2023@daltonschool.kr'],
      subject: 'CDS App Feedback',
      body: getOS() + " " + version,
    );

    await launch('$mailtoLink');
  }

  String getOS() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    }
    return "";
  }

  Future<void> logOutBoolean() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userInfo.setGraduationYear("graduationYear");
      userInfo.setId("id");
      userInfo.setImageLink("imageLink");
      userInfo.setEmail("email");
      userInfo.setSchool("school");
      userInfo.setFirst("first");
      userInfo.setLast("last");
      loggedIn = false;
      went = 0;
      prefs.setString('UserMail', "noData");
    });
  }

  void logInBoolean() {
    loggedIn = true;
  }
}
