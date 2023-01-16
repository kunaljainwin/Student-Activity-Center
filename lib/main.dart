import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samadhyan/widgets/login_helpers.dart';
import 'package:samadhyan/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:url_strategy/url_strategy.dart';

// Backend analytics
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint("Opened through background message");
}

// Driver Program
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyAWT3g73HTwiePpKXDywTs3z4_--2_C0zU",
              authDomain: "visitcounter-fef16.firebaseapp.com",
              databaseURL:
                  "https://visitcounter-fef16-default-rtdb.firebaseio.com",
              projectId: "visitcounter-fef16",
              storageBucket: "visitcounter-fef16.appspot.com",
              messagingSenderId: "684329885216",
              appId: "1:684329885216:web:fe77d493c10d3eaa032645",
              measurementId: "G-WNB3QKWVJ2")
          : null);

  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  firebaseAppCheck.activate(
      webRecaptchaSiteKey: "AC7B8005-1374-459D-90E2-50BA207FB3BC",
      androidDebugProvider: devMode);

  if (kIsWeb) {
  } else {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // Processing of Push Notifications
    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    await FirebaseMessaging.instance.getToken().then((value) {
      userNewFCMToken = value!;
      debugPrint(userNewFCMToken);
    });

    // await MongoDB.connect();

    // await RemoteConfigService().initialize();
    // RemoteConfigService().showMainBanner
    //     ? print("Banner is on")
    //     : print("Banner is off");

    // firebaseAppCheck.getToken().then((value) {
    //   print(value);
    // });

    // firebaseAppCheck.installAppCheckProviderFactory(
    //     PlayIntegrityAppCheckProviderFactory.getInstance());
    // FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;

    // firebaseAppCheck.activate();
    // firebaseAppCheck.getToken();
    // firebaseAppCheck.setTokenAutoRefreshEnabled(true);

    // MessagingService.openInitialScreenFromMessage();
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    //   print("receieved message" + event.toString());
    //   await MessagingService.initialize(onSelectNotification).then((value) {
    //     print("receieved message" + value.toString());
    //     MessagingService.onMessageOpenedApp.listen(_pageOpenForOnLaunch(event));
    //   });
    // });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: devMode,
        home: passwordLessSignIn(context),
        theme: ThemeData(
          // primaryColor: Colors.white,
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(),
          primaryTextTheme: GoogleFonts.openSansTextTheme(),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle:
                      TextStyle(fontFamily: GoogleFonts.lato().fontFamily))),
          // dialogTheme: DialogTheme(
          //     alignment: const Alignment(0, -0.5),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10))),
          // outlinedButtonTheme: OutlinedButtonThemeData(
          //     style: OutlinedButton.styleFrom(s
          //         textStyle: const TextStyle(color: Colors.black))),
        ),
      );
    });
  }
}
