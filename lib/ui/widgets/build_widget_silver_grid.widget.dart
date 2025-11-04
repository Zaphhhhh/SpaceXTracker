import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/launch.model.dart';
import '../../utils/date_formatter.dart';
import '../pages/details.page.dart';
import 'launch_grid_card.widget.dart';

Widget buildSliverGrid(List<Launch> launches) {
  return SliverPadding(
    padding: const EdgeInsets.all(16.0),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final launch = launches[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (contexte) => Details(launch: launch)),
            );
          },
          child: LaunchGridCard(
            missionName: launch.name!.toUpperCase(),
            launchDate: DateFormatter()
                .formatDateManually(launch.dateUtc)
                .split(' à ')[0],
            succesInfo: launch.success == true
                ? 'Succès'
                : (launch.success == false ? 'Échec' : 'Statut inconnu'),
            launchImage: Image.network(
              "${launch.links?.patch?.small}",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      }, childCount: launches.length),
    ),
  );
}
