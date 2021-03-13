import 'package:bon_appetit_user/screens/qr_viewer.dart';
import 'package:bon_appetit_user/shared/loading.dart';
import 'package:bon_appetit_user/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  bool isLoading = false;
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context){
                            return QRViewer();
                          }));
                      // try {
                      //   ScanResult codeScanner = await BarcodeScanner.scan();
                      //   setState(() {
                      //     qrCodeResult = codeScanner.rawContent;
                      //   });
                      //   bool result =
                      //       await ConnectivityService.getConnectivityStatus();
                      //   if (result) {
                      //     if (qrCodeResult != '') {
                      //       if (qrCodeResult.endsWith('food') &&
                      //           qrCodeResult.length == 32) {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => MenuScreen(
                      //               restaurantId: qrCodeResult,
                      //             ),
                      //           ),
                      //         );
                      //       } else {
                      //         ToastClass.buildShowToast('Invalid QR code');
                      //       }
                      //     }
                      //   } else {
                      //     ToastClass.buildShowToast('no internet connection');
                      //   }
                      //
                      //   if (!_disposed) {
                      //     setState(() {
                      //       isLoading = false;
                      //     });
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
