import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../../data/models/launch.model.dart';
import '../../utils/date_formatter.dart';

class Details extends StatelessWidget {
  final Launch launch;
  static const String placeholderImage = 'https://via.placeholder.com/300';
  const Details({super.key, required this.launch});

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open the URL: $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = launch.links?.flickr?.original ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFF1A1A2E),
            floating: true,
            snap: true,
            elevation: 0,
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: DropShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                        opacity: 1,
                        color: Colors.black,
                        child: Image.network(
                          launch.links?.patch?.small ?? placeholderImage,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    launch.name?.toUpperCase() ?? 'NO NAME',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormatter()
                        .formatDateManually(launch.dateUtc)
                        .split(' à ')[0],
                  ),
                  const SizedBox(height: 10),
                  SuccessBubble(
                    successInfo: launch.success == true
                        ? 'Succès'
                        : (launch.success == false
                              ? 'Échec'
                              : 'Statut inconnu'),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Description: ${launch.details ?? "Aucune description disponible."}",
                  ),
                  const SizedBox(height: 10),
                  if (launch.failures != null && launch.failures!.isNotEmpty)
                    Text(
                      "Raison: ${launch.failures?.first?.reason ?? "Aucune raison disponible."}",
                    ),
                  const SizedBox(height: 30),
                  // The gallery title
                  if (images.isNotEmpty)
                    const Text(
                      "GALLERY",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              final imageUrl = images[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => _launchUrl(imageUrl, context),
                    child: Image.network(imageUrl),
                  ),
                ),
              );
            }, childCount: images.length),
          ),
        ],
      ),
    );
  }
}
