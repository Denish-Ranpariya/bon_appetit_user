import 'package:bon_appetit_user/services/auth_service.dart';
import 'package:bon_appetit_user/shared/toast.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey[700]),
      backgroundColor: Color(0xFFc9e3db),
      elevation: 0,
      title: Text(
        'Bon Appetit',
        style: TextStyle(color: Colors.grey[800]),
      ),
      actions: <Widget>[
        TextButton.icon(
          label: Text('Logout'),
          icon: Icon(
            Icons.person,
            color: Colors.grey[800],
          ),
          onPressed: () async {
            try {
              Navigator.pop(context);
              await AuthService().logout();
              ToastClass.buildShowToast('Logged out');
            } catch (e) {
              print(e.toString());
            }
          },
        ),
      ],
    );
  }
}
