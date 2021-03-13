import 'package:bon_appetit_user/screens/qr_screen.dart';
import 'package:bon_appetit_user/widgets/alert_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        User user = snapshot.data;
        if (user != null) {
          return WillPopScope(onWillPop: onPressedBack, child: QrScreen());
        } else {
          return WillPopScope(onWillPop: onPressedBack, child: LoginScreen());
        }
      },
    );

  }
}
