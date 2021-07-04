// @dart=2.9
import 'dart:io';

import 'package:apitesting/includingfiles/documents/privacy.dart';
import 'package:apitesting/includingfiles/documents/terms.dart';
import 'package:apitesting/version.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'includingfiles/Dates.dart';
import 'includingfiles/constant/constants.dart';
import 'includingfiles/categories.dart';
import 'includingfiles/homepage/homepages.dart';
import 'includingfiles/liveSports.dart';
import 'includingfiles/lunch.dart';
import 'package:mailto/mailto.dart';

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
    badge: true,//or fix this shit fast
    sound: true,
  );
//bitch get me out O btw my emulator is fucked up I cant get to the notification page wtf???? create new emulator this is like my 10th time every time it pussies out like this
  runApp(MyApp());// can u like fucking fix it
  //send me the entire project rn ill test notifications while u work on fixing this doghsit
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
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
      print("onMEssageOpenedApp event");
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

  bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              loggedIn ? 

              //LOGGED IN
              Container(
                height: 220,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage('images/cds.jpg'),
                      colorFilter: ColorFilter.mode(Color(0xF1f0e03).withOpacity(0.75), BlendMode.srcOver),
                      fit: BoxFit.cover,
                    ),
                  ),
                  currentAccountPictureSize: Size.square(90),
                  currentAccountPicture: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF77889),
                    backgroundImage: NetworkImage( //try before this shit crashes again wait idk if this shit is configured yetMATE how do i fucking lohower this shit i gotta see first
                        "https://i.pinimg.com/474x/ca/49/50/ca495017eec9dad55892423007d8286e.jpg"),
                  ),
                  accountName: Container(
                    child: Text(
                      "Victor Shin",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  accountEmail: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Container(
                      child: Text(
                        "wooseokshin2023@daltonschool.kr",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ) : 

              //NOT LOGGED IN
              Container(
                height: 220,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage('images/cds.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ), child: null,
                ),
              ),


              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    //Container(
                    //  height: 220,
                    //  child: DrawerHeader(
                    //    decoration: BoxDecoration(
                    //      image: new DecorationImage(
                    //          image: AssetImage('images/cds.jpg'),
                    //          fit: BoxFit.cover),
                    //    ),
                    //  ),
                    //),
                    //ListTile(
                    //  leading: Icon(Icons.info),
                    //  title: Text(
                    //    'About',
                    //    style: TextStyle(
                    //      color: fontColor,
                    //      fontSize: 18,
                    //    ),
                    //  ),
                    //  onTap: () {
                    //    //
                    //  },
                    //),
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
                    //ListTile(
                    //  leading: Icon(Icons.notifications),
                    //  title: Text(
                    //    'Notifications',
                    //    style: TextStyle(
                    //      color: fontColor,
                    //      fontSize: 18,
                    //    ),
                    //  ),
                    //  onTap: () {},
                    //),
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
                        loggedIn ? logOutBoolean() : logInBoolean();
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
          children: [
            AllTabView(),
            Cate(),
            Lunch(),
            Dates(),
          ],
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

  void logOutBoolean() {
    setState(() {
      loggedIn = false;
    });
  }

  void logInBoolean() {
    setState(() {
      loggedIn = true;
    });
  }
}
