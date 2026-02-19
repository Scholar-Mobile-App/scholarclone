import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/presentation/students/web_view/web_view_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/cs.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({super.key});
  final WebViewCon _controller = Get.put(WebViewCon());
  final _key = UniqueKey();
  final WebViewController webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        _controller.data["title"],
      ),
      body: WebViewWidget(
        key: _key,
        controller: webViewController
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              _controller.data[CS.url],
            ),
          ),
      ),
    );
  }
}
