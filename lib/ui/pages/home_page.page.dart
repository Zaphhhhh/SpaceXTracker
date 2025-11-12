// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:spacex_app/ui/widgets/onboarding/onboarding_complete.widget.dart';
import '../../data/api/spacex.service.dart';
import '../../data/models/launch.model.dart';
import '../widgets/build_widget_silver_grid.widget.dart';
import '../widgets/build_widget_silver_list.widget.dart';

enum SortOption { nameAsc, nameDesc, dateAsc, dateDesc, favorites }

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<List<Launch>> futureLaunches;
  bool isGridView = false;
  SortOption _sortOption = SortOption.dateDesc;
  List<Launch> _allLaunches = [];
  List<Launch> launches = [];
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _favoriteLaunchIds = {};

  // --- NOUVEAUX AJOUTS POUR L'ONBOARDING ---
  bool _showOnboarding = false;

  @override
  void initState() {
    super.initState();
    futureLaunches = SpaceXService.getAll();
    _searchController.addListener(_filterLaunches);
    _checkIfOnboardingNeeded(); // On vérifie au démarrage
  }

  Future<void> _checkIfOnboardingNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    // Si 'onboarding_complete' n'a jamais été défini ou est faux, on affiche l'onboarding
    if (prefs.getBool('onboarding_complete') != true) {
      setState(() {
        _showOnboarding = true;
      });
    }
  }

  void _onOnboardingEnd() async {
    final prefs = await SharedPreferences.getInstance();
    // On sauvegarde le fait que l'utilisateur a terminé
    await prefs.setBool('onboarding_complete', true);
    // On met à jour l'état pour cacher le widget d'onboarding
    setState(() {
      _showOnboarding = false;
    });
  }
  // --- FIN DES NOUVEAUX AJOUTS ---

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  // ... (TOUT LE RESTE DE VOTRE LOGIQUE : _toggleFavorite, _filterLaunches, etc. reste INCHANGÉ)
  void _toggleFavorite(String launchId) {
    setState(() {
      if (_favoriteLaunchIds.contains(launchId)) {
        _favoriteLaunchIds.remove(launchId);
      } else {
        _favoriteLaunchIds.add(launchId);
      }

      final index = _allLaunches.indexWhere((launch) => launch.id == launchId);
      if (index != -1) {
        _allLaunches[index].isFavorite = !_allLaunches[index].isFavorite;
      }
    });

    if (_sortOption == SortOption.favorites) {
      _updateLaunchesList();
    }
  }

  void _filterLaunches() {
    _updateLaunchesList();
  }

  void _sortLaunches(SortOption option) {
    setState(() {
      _sortOption = option;
    });
    _updateLaunchesList();
  }

  void _updateLaunchesList() {
    final query = _searchController.text.toLowerCase();
    List<Launch> updatedList;

    if (_sortOption == SortOption.favorites) {
      updatedList = _allLaunches
          .where((launch) => _favoriteLaunchIds.contains(launch.id))
          .toList();
    } else {
      updatedList = List.from(_allLaunches);
    }

    if (query.isNotEmpty) {
      updatedList = updatedList.where((launch) {
        return launch.name!.toLowerCase().contains(query);
      }).toList();
    }

    switch (_sortOption) {
      case SortOption.nameAsc:
        updatedList.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case SortOption.nameDesc:
        updatedList.sort((a, b) => b.name!.compareTo(a.name!));
        break;
      case SortOption.dateAsc:
        updatedList.sort((a, b) => a.dateUtc!.compareTo(b.dateUtc!));
        break;
      case SortOption.dateDesc:
        updatedList.sort((a, b) => b.dateUtc!.compareTo(a.dateUtc!));
        break;
      case SortOption.favorites:
        updatedList.sort((a, b) => a.name!.compareTo(b.name!));
        break;
    }

    setState(() {
      launches = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      // On utilise un Stack pour superposer l'onboarding
      body: Stack(
        children: [
          // 1. Votre interface principale reste ici
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xFF1A1A2E),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.rocket_launch, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "SpaceX Tracker",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                floating: true,
                snap: true,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(76.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Rechercher un lancement...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF2A2A3E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 10,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Lancements",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isGridView ? Icons.view_list : Icons.grid_view,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: toggleView,
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Launch>>(
                future: futureLaunches,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Une erreur est survenue: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    if (_allLaunches.isEmpty) {
                      _allLaunches = snapshot.data!;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _updateLaunchesList();
                      });
                    }

                    return isGridView
                        ? buildSliverGrid(
                            launches,
                            _favoriteLaunchIds,
                            _toggleFavorite,
                          )
                        : buildSliverList(
                            launches,
                            _favoriteLaunchIds,
                            _toggleFavorite,
                          );
                  } else {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Aucun lancement trouvé.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),

          // 2. On affiche l'onboarding par-dessus si nécessaire
          if (_showOnboarding) OnboardingComplete(onDone: _onOnboardingEnd),
        ],
      ),
      floatingActionButton: _showOnboarding
          ? null // Si l'onboarding est affiché, on ne met PAS de bouton
          : SpeedDial(
              // Sinon, on affiche le SpeedDial
              animatedIcon: AnimatedIcons.menu_close,
              icon: Icons.sort,
              backgroundColor: Colors.orange,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.favorite),
                  backgroundColor: Colors.redAccent,
                  label: 'Favoris (A-Z)',
                  onTap: () => _sortLaunches(SortOption.favorites),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.arrow_downward),
                  label: 'Nom (Z-A)',
                  onTap: () => _sortLaunches(SortOption.nameDesc),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.arrow_upward),
                  label: 'Nom (A-Z)',
                  onTap: () => _sortLaunches(SortOption.nameAsc),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.arrow_downward),
                  label: 'Date (plus récente)',
                  onTap: () => _sortLaunches(SortOption.dateDesc),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.arrow_upward),
                  label: 'Date (plus ancienne)',
                  onTap: () => _sortLaunches(SortOption.dateAsc),
                ),
              ],
            ),
    );
  }
}
