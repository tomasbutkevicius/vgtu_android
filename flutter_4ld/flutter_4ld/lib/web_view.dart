import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}