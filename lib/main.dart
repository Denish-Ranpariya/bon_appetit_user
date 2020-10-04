import 'package:bon_appetit_user/screens/qr_screen.dart';
import 'package:bon_appetit_user/widgets/alert_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MySplash(),
    );
  }
}

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  Future<bool> onPressedBack() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialogBox(
        textMessage: 'Do you really want to close the app?',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SplashScreen(
      photoSize: 100,
      seconds: 3,
      title: Text(
        'Bon Appetit',
        style: GoogleFonts.patuaOne(
          fontSize: 30,
          color: Colors.grey[700],
          fontWeight: FontWeight.w400,
        ),
      ),
      image: Image(
        image: AssetImage('images/soup.png'),
      ),
      backgroundColor: Color(0xffc9e3db),
      navigateAfterSeconds:
          WillPopScope(onWillPop: onPressedBack, child: QrScreen()),
    );
  }
}
