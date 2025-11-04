import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../data/api/spacex.service.dart';
import '../../data/models/launch.model.dart';
import '../widgets/build_widget_silver_grid.widget.dart';
import '../widgets/build_widget_silver_list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<List<Launch>> futureLaunches;
  bool isGridView = false;

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
                final launches = snapshot.data!;
                return isGridView
                    ? buildSliverGrid(launches)
                    : buildSliverList(launches);
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
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Ajouter',
            onTap: () => print('Ajouter'),
          ),
          SpeedDialChild(
            child: Icon(Icons.edit),
            label: 'Modifier',
            onTap: () => print('Modifier'),
          ),
          SpeedDialChild(
            child: Icon(Icons.delete),
            label: 'Supprimer',
            onTap: () => print('Supprimer'),
          ),
        ],
      ),
    );
  }
}
