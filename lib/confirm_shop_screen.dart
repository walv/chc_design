import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmShopScreen extends StatefulWidget {
  @override
  _ConfirmShopScreenState createState() => _ConfirmShopScreenState();
}

class _ConfirmShopScreenState extends State<ConfirmShopScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return WebView(
              initialUrl:
                  'https://shopee.co.id/realme-Watch-S-Pro-AMOLED-Screen-GPS-5ATM-Water-Resistant--i.109598751.6975299725',
              javascriptMode: JavascriptMode.unrestricted,
            );
          },
        ),
      ),
    );
  }
}
