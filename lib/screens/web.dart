import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';

class MyWebView extends StatelessWidget {
  final NewspaperList newspaper;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  MyWebView(
    @required this.newspaper,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Hero(
              tag: 'imageHero${newspaper.icon}',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/${newspaper.icon}",
                ),
              ),
            ),
            centerTitle: true,
            leading: BackButton(color: Colors.black),
          ),
          body: WebView(
            initialUrl: newspaper.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          )),
    );
  }
}
