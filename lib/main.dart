import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictiknew/Pages/Profile.dart';
import 'Common/Constants.dart' as cnst;
import 'Screen/ChangeStudio.dart';
import 'Screen/ContactList.dart';
import 'Screen/GuestDashboard.dart';
import 'Screen/GuestAboutUs.dart';
import 'Screen/AddCustomer.dart';
import 'Screen/BookAppointment.dart';
import 'Screen/CustomerAboutUs.dart';
import 'Screen/Dashboard.dart';
import 'Screen/Login.dart';
import 'Screen/LoginWithUsername.dart';
import 'Screen/MyInvites.dart';
import 'Screen/CustomerNotificationPage.dart';
import 'Screen/OTPVerification.dart';
import 'Screen/PortfolioScreen.dart';
import 'Screen/ReferAndEarn.dart';
import 'Screen/SelectSound.dart';
import 'Screen/SignUpGuest.dart';
import 'Screen/SocialLink.dart';
import 'Screen/Splash.dart';
import 'Screen/StudioLocation.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = new IOSInitializationSettings();
    // var initializationSettings = new InitializationSettings( AndroidInitializationSettings('app_icon'),, initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     selectNotification: onSelectNotification);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    secureScreen();
    //========
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Pictik",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/Login': (context) => Login(),
          '/LoginWithUsername': (context) => LoginWithUsername(),
          '/OTPVerification': (context) => OTPVerification(),
          '/Dashboard': (context) => Dashboard(),
          '/SignUpGuest': (context) => SignUpGuest(),
          '/SelectSound': (context) => SelectSound(),
          '/AddCustomer': (context) => AddCustomer(),
          '/ContactList': (context) => ContactList(),
          '/PortfolioScreen': (context) => PortfolioScreen(),
          '/ReferAndEarn': (context) => ReferAndEarn(),
          '/GuestAboutUs': (context) => GuestAboutUs(),
          '/SocialLink': (context) => SocialLink(),
          '/MyCustomer': (context) => MychildCustomerList(),
          '/BookAppointment': (context) => BookAppointment(),
          '/CustomerNotificationPage': (context) => CustomerNotificationPage(),
          '/GuestDashboard': (context) => GuestDashboard(),
          '/StudioLocation': (context) => StudioLocation(),
          '/CustomerAboutUs': (context) => CustomerAboutUs(),
          '/ChangeStudio': (context) => ChangeStudio(),
          '/Profile': (context) => Profile(),
        },
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: cnst.appPrimaryMaterialColorPink,
          accentColor: cnst.appPrimaryMaterialColorPink,
          buttonColor: cnst.appPrimaryMaterialColorPink,
        ));
  }
}
