import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenLinkOnWebBrowser extends StatefulWidget {
  const OpenLinkOnWebBrowser({Key? key}) : super(key: key);

  @override
  State<OpenLinkOnWebBrowser> createState() => _OpenLinkOnWebBrowserState();
}

class _OpenLinkOnWebBrowserState extends State<OpenLinkOnWebBrowser> {
  void _launchURL() async {
    final Uri url = Uri.parse("https://facebook.com");

    if (await canLaunchUrl(url)) {

      await launchUrl(
        url,
        mode: LaunchMode.externalApplication
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Web Browser"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _launchURL,
            child: const Text("Open link"),
          )
        ],
      ),
    );
  }
}
