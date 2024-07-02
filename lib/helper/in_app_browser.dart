import 'dart:developer';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    log("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    log("Started URL: $url");
  }

  @override
  Future onLoadStop(url) async {
    log("Stopped URL: $url");
  }

  @override
  void onProgressChanged(progress) {
    log("Progress: $progress");
  }

  @override
  void onExit() {
    log("Browser closed!");
  }
}
