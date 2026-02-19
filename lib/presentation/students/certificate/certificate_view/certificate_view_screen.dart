import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../widgets/app_bar.dart';

class CertificateViewScreen extends StatelessWidget {
  CertificateViewScreen({this.html, super.key});
  final dynamic html;
  final WebViewController controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "Certificate",
        rounded: false,
      ),
      body: WebViewWidget(
        controller: controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.dataFromString(
              html,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ),
          ),
      ),
    );
  }

  void loadHtml() async {
    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    controller.loadRequest(Uri.parse(url));
  }
}
