import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/launch_links.model.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksSectionWidget extends StatelessWidget {
  final LaunchLinks links;

  const LinksSectionWidget({super.key, required this.links});

  void _launchURL(String urlString, BuildContext context) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible d\'ouvrir le lien : $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> linkTiles = [];
    final redditLinks = links.reddit;

    void addLinkTile(String? url, String title, IconData icon) {
      if (url != null && url.isNotEmpty) {
        linkTiles.add(
          ListTile(
            leading: Icon(icon, color: Colors.white70),
            title: Text(title),
            trailing: const Icon(
              Icons.open_in_new,
              color: Colors.white70,
              size: 20,
            ),
            onTap: () => _launchURL(url, context),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        );
      }
    }

    final webcastUrl =
        links.webcast ??
        (links.youtubeId != null
            ? 'https://www.youtube.com/watch?v=${links.youtubeId}'
            : null);

    addLinkTile(links.article, 'Article', Icons.article_outlined);
    addLinkTile(links.wikipedia, 'Wikipedia', Icons.public);
    addLinkTile(webcastUrl, 'Vidéo', Icons.videocam_outlined);
    addLinkTile(
      links.presskit,
      'Dossier de presse',
      Icons.description_outlined,
    );

    if (redditLinks != null) {
      addLinkTile(redditLinks.launch, 'Reddit (Lancement)', Icons.reddit);
      addLinkTile(redditLinks.campaign, 'Reddit (Campagne)', Icons.reddit);
      addLinkTile(redditLinks.media, 'Reddit (Média)', Icons.reddit);
      addLinkTile(redditLinks.recovery, 'Reddit (Récupération)', Icons.reddit);
    }

    if (linkTiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Liens :",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...linkTiles,
      ],
    );
  }
}
