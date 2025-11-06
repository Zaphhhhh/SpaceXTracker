import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../data/api/spacex.service.dart';
import '../../data/models/launch.model.dart';
import '../widgets/build_widget_silver_grid.widget.dart';
import '../widgets/build_widget_silver_list.widget.dart';

enum SortOption { name, date }

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<List<Launch>> futureLaunches;
  bool isGridView = false;
  SortOption _sortOption = SortOption.date;
  List<Launch> launches = [];
  final Set<String> _favoriteLaunchIds = {};

  @override
  void initState() {
    super.initState();
    futureLaunches = SpaceXService.getAll();
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void _toggleFavorite(String launchId) {
    setState(() {
      if (_favoriteLaunchIds.contains(launchId)) {
        _favoriteLaunchIds.remove(launchId);
      } else {
        _favoriteLaunchIds.add(launchId);
      }
      final index = launches.indexWhere((launch) => launch.id == launchId);
      if (index != -1) {
        launches[index].isFavorite = !launches[index].isFavorite;
      }
    });
  }

  void _sortLaunches(SortOption option) {
    setState(() {
      _sortOption = option;
      if (launches.isNotEmpty) {
        if (_sortOption == SortOption.name) {
          launches.sort((a, b) => a.name!.compareTo(b.name!));
        } else {
          launches.sort((a, b) => a.dateUtc!.compareTo(b.dateUtc!));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: CustomScrollView(
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
            elevation: 0,
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    isGridView ? Icons.view_list : Icons.grid_view,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: toggleView,
                ),
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
                if (launches.isEmpty) {
                  launches = snapshot.data!;
                  for (var launch in launches) {
                    if (_favoriteLaunchIds.contains(launch.id)) {
                      launch.isFavorite = true;
                    }
                  }
                  if (_sortOption == SortOption.name) {
                    launches.sort((a, b) => a.name!.compareTo(b.name!));
                  } else {
                    launches.sort((a, b) => a.dateUtc!.compareTo(b.dateUtc!));
                  }
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        icon: Icons.sort,
        backgroundColor: Colors.orange,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.sort_by_alpha),
            label: 'Trier par nom',
            onTap: () => _sortLaunches(SortOption.name),
          ),
          SpeedDialChild(
            child: const Icon(Icons.date_range),
            label: 'Trier par date',
            onTap: () => _sortLaunches(SortOption.date),
          ),
        ],
      ),
    );
  }
}
