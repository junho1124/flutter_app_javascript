import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool canGoBack = await _webViewController.canGoBack();
        if (canGoBack) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('web View'),
        ),
        body: WebView(
            initialUrl: 'https://m.naver.com/',
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: Text(
                  "loadUrl",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  _webViewController.loadUrl('https://survivalcoding.com/');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                child: Text(
                  'goBack',
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () async {
                  bool canGoBack = await _webViewController.canGoBack();
                  if (canGoBack) {
                    _webViewController.goBack();
                  }
                  // _webViewController.canGoBack().then((value) {
                  //   if (value) {
                  //     _webViewController.goBack();
                  //   }
                  // });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
