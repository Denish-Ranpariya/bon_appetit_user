import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
import 'package:bon_appetit_user/services/connectivity_service.dart';
import 'package:bon_appetit_user/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bon_appetit_user/shared/toast.dart';

import 'menu_screen.dart';

class QRViewer extends StatefulWidget {
  @override
  _QRViewerState createState() => _QRViewerState();
}

class _QRViewerState extends State<QRViewer> {
  bool isLoading = false;
  bool _disposed = false;
  final AnimatedQRViewController controller = AnimatedQRViewController();

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Loading() : Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 12,
            child: AnimatedQRView(
              squareColor: Colors.green.withOpacity(0.25),
              animationDuration: const Duration(milliseconds: 400),
              onScan: (String str) async {
                try {
                  bool result =
                  await ConnectivityService.getConnectivityStatus();
                  if (result) {
                    if (str != '') {
                      if (str.endsWith('food') &&
                          str.length == 32) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuScreen(
                              restaurantId: str,
                            ),
                          ),
                        );
                      } else {
                        ToastClass.buildShowToast('Invalid QR code');
                      }
                    }
                  } else {
                    ToastClass.buildShowToast('no internet connection');
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
              controller: controller,
            ),
          ),
          Expanded(
            flex: 1,
            // ignore: deprecated_member_use
            child: FlatButton(
              color: Colors.pink[400],
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
