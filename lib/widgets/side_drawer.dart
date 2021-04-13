import 'dart:ui';
import 'package:bon_appetit_user/screens/qr_viewer.dart';
import 'package:bon_appetit_user/screens/your_order.dart';
import 'package:bon_appetit_user/services/auth_service.dart';
import 'package:bon_appetit_user/shared/constants.dart';
import 'package:bon_appetit_user/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Color(0xFFc9e3db),
            padding: EdgeInsets.symmetric(vertical: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Bon Appetit',
                  style: kScreenHeadingTextStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage:
                  NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  FirebaseAuth.instance.currentUser.displayName ?? "",
                  style: kTileTextStyle.copyWith(
                    letterSpacing: .2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => YourOrderScreen()
                ),
              );
            },
            child: Center(
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.shoppingBag,
                  color: Colors.grey[700],
                ),
                title: Text('Your orders'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return QRViewer();
                }));
              } catch (e) {
                print(e);
              }
            },
            child: Center(
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.grey[700],
                ),
                title: Text('Scan'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                Navigator.pop(context);
                await AuthService().logout();
                ToastClass.buildShowToast('Logged out');
              } catch (e) {
                print(e.toString());
              }
            },
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.grey[700],
                ),
                title: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
