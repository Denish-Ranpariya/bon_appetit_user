import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/screens/qr_viewer.dart';
import 'package:bon_appetit_user/services/database_service.dart';
import 'package:bon_appetit_user/shared/constants.dart';
import 'package:bon_appetit_user/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'food_item_list.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantId;

  MenuScreen({this.restaurantId});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FoodItem>>.value(
      value: DatabaseService(id: widget.restaurantId).foodItems,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TopBar(
          iconData: FontAwesomeIcons.qrcode,
          iconTitle: 'Scan',
          onPressed: () async {
            try {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return QRViewer();
              }));
            } catch (e) {
              print(e);
            }
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: kUpperBoxDecoration,
              child: Column(
                children: [
                  StreamBuilder(
                    stream:
                        DatabaseService(id: widget.restaurantId).restaurantData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.restaurantName,
                          style: kScreenHeadingTextStyle,
                        );
                      } else {
                        return Text('');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Veg.'),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Non Veg.'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FoodItemList(),
            ),
          ],
        ),
      ),
    );
  }
}
