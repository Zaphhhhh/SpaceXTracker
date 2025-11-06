import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/gallery.widget.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';
import 'package:spacex_app/ui/widgets/text_wrapper.widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/launch.model.dart';
import '../../utils/date_formatter.dart';

class Details extends StatefulWidget {
  final Launch launch;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  static const String placeholderImage = 'https://via.placeholder.com/300';

  const Details({
    super.key,
    required this.launch,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _isGalleryExpanded = false;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.launch.links?.flickr?.original ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: const Color(0xFF1A1A2E),
            floating: true,
            snap: true,
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                    widget.onFavoriteToggle();
                  },
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: DropShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                        opacity: 1,
                        color: Colors.black,
                        child: Image.network(
                          widget.launch.links?.patch?.small ??
                              Details.placeholderImage,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      widget.launch.name?.toUpperCase() ?? 'NO NAME',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      DateFormatter()
                          .formatDateManually(widget.launch.dateUtc)
                          .split(' à ')[0],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SuccessBubble(
                      successInfo: widget.launch.success == true
                          ? 'Succès'
                          : (widget.launch.success == false
                                ? 'Échec'
                                : 'Statut inconnu'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextWrapper(
                    text:
                        "${widget.launch.details ?? "Aucune description disponible."}",
                  ),
                  const SizedBox(height: 10),
                  if (widget.launch.failures != null &&
                      widget.launch.failures!.isNotEmpty)
                    Text(
                      "Raison: ${widget.launch.failures?.first?.reason ?? "Aucune raison disponible."}",
                    ),
                  const SizedBox(height: 30),

                  if (images.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isGalleryExpanded = !_isGalleryExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Galerie: ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              _isGalleryExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_isGalleryExpanded) Gallery(images: images),
        ],
      ),
    );
  }
}
