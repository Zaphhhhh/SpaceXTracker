import 'dart:convert';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spacex_app/data/models/rocket.model.dart';
import 'package:spacex_app/ui/widgets/gallery.widget.dart';
import 'package:spacex_app/ui/widgets/launch_details_section.widget.dart';
import 'package:spacex_app/ui/widgets/links_section.widget.dart';
import 'package:spacex_app/ui/widgets/rocket_details_section.widget.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';
import 'package:spacex_app/ui/widgets/text_wrapper.widget.dart';
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

  Rocket? _rocket;
  bool _isLoadingRocket = true;
  String? _rocketError;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _fetchRocketDetails();
  }

  Future<void> _fetchRocketDetails() async {
    final rocketId = widget.launch.rocket;

    if (rocketId == null) {
      setState(() {
        _isLoadingRocket = false;
        _rocketError = "Aucun ID de fusée n'est disponible pour ce lancement.";
      });
      return;
    }

    try {
      final url = Uri.parse('https://api.spacexdata.com/v4/rockets/$rocketId');
      final response = await http.get(url);

      if (mounted) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            _rocket = Rocket.fromJson(data);
            _isLoadingRocket = false;
          });
        } else {
          setState(() {
            _isLoadingRocket = false;
            _rocketError =
                "Erreur ${response.statusCode} lors de la récupération des données de la fusée.";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingRocket = false;
          _rocketError =
              "Impossible de se connecter au serveur. Vérifiez votre connexion internet.";
        });
      }
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 30),
                  LaunchDetailsSection(launch: widget.launch),
                  const SizedBox(height: 30),
                  if (_isLoadingRocket)
                    const Center(child: CircularProgressIndicator())
                  else if (_rocket != null)
                    RocketDetailsSection(rocket: _rocket!)
                  else if (_rocketError != null)
                    Center(
                      child: Text(
                        _rocketError!,
                        style: const TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          if (images.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isGalleryExpanded = !_isGalleryExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Galerie ",
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
              ),
            ),

          if (_isGalleryExpanded) Gallery(images: images),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 32.0),
              child: widget.launch.links != null
                  ? LinksSectionWidget(links: widget.launch.links!)
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
