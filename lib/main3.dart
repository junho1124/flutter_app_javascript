import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


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
            initialUrl: 'https://junho1124.github.io/web_test/post.html',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                    Navigator.pop(context, _toasterJavascriptChannel(context));
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
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'messageHnadler',
        onMessageReceived: (JavascriptMessage message) {
          print('값은 ${message.message}');
         Navigator.pop(context, message.message);
        });
  }

}
