import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableImage extends StatelessWidget {
  final String url;

  const ClickableImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clickable Image Example')),
      body: Center(
        child: InkWell(
          onTap: _launchUrl,
          child: Image.network(url, width: 300),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
