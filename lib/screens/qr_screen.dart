import 'package:barcode_scan/barcode_scan.dart';
import 'package:bon_appetit_user/screens/menu_screen.dart';
import 'package:bon_appetit_user/services/auth_service.dart';
import 'package:bon_appetit_user/shared/loading.dart';
import 'package:bon_appetit_user/widgets/bottom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String qrCodeResult = '';
  bool isLoading = false;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 110),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'images/soup.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Bon Appetit',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patuaOne(
                        fontSize: 40,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  BottomButton(
                    buttonText: 'Scan',
                    onPressed: () async {
                      try {
                        ScanResult codeScanner = await BarcodeScanner.scan();
                        setState(() {
                          qrCodeResult = codeScanner.rawContent;
                        });
                        if (qrCodeResult != '') {
                          print(qrCodeResult);
                          setState(() {
                            isLoading = true;
                          });
                          FirebaseUser user = await AuthService().signInAnon();
                          print(user.uid);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuScreen(
                                restaurantId: qrCodeResult,
                              ),
                            ),
                          );
                        }
                        if (!_disposed) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
