import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  late WebViewPlusController _controller;
  double _height = 1;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          translation(context).privacy_policy,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: _height,
            child: WebViewPlus(
              onWebViewCreated: (controller) {
                _controller = controller;
                controller.loadUrl(
                  translation(context).clang == 'en'
                      ? 'assets/privacy.html'
                      : translation(context).clang == 'ru'
                          ? 'assets/privacy_ru.html'
                          : 'assets/privacy_kk.html',
                );
              },
              onPageFinished: (url) {
                _controller.getHeight().then((double height) {
                  setState(() {
                    _height = height;
                    loading = false;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        ],
      ),
    );
  }
}
