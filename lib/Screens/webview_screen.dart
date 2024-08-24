import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_circular_progress.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSiteScreen extends StatefulWidget {
  @override
  WebSiteScreenState createState() => WebSiteScreenState();
}

class WebSiteScreenState extends State<WebSiteScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Check Your Internet.')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.clickatcareer.com'));
  }

  Future<bool> _handleBackNavigation(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => _handleBackNavigation(context),
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (isLoading)
                Center(
                  child: CustomCircularProgress()
                ),
            ],
          ),
        ),
      ),
    );
  }
}
