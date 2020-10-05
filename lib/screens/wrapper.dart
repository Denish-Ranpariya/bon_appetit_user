import 'package:bon_appetit_user/screens/qr_screen.dart';
import 'package:bon_appetit_user/widgets/alert_dialog_box.dart';
import 'package:flutter/material.dart';

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
    return WillPopScope(onWillPop: onPressedBack, child: QrScreen());
  }
}
