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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Hero(
              tag: 'imageHero${newspaper.url}',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset(
                    "images/${newspaper.icon}",
                  ),
                ),
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
        ));
  }
}
