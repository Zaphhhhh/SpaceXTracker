import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/launch.model.dart';
import '../../utils/date_formatter.dart';
import '../pages/details.page.dart';
import 'launch_card.widget.dart';

String formatDateManually(DateTime? date) {
  if (date == null) {
    return 'Date non spécifiée';
  }
  const List<String> mois = [
    'janvier',
    'février',
    'mars',
    'avril',
    'mai',
    'juin',
    'juillet',
    'août',
    'septembre',
    'octobre',
    'novembre',
    'décembre',
  ];
  final jour = date.day;
  final nomDuMois = mois[date.month - 1];
  final annee = date.year;
  final heure = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$jour $nomDuMois $annee à $heure:$minute';
}

Widget buildSliverList(List<Launch> launches) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      final launch = launches[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (contexte) => Details(launch: launch)),
            );
          },
          child: LaunchCard(
            missionName: launch.name!.toUpperCase(),
            launchDate: DateFormatter()
                .formatDateManually(launch.dateUtc)
                .split(' à ')[0],
            succesInfo: launch.success == true
                ? 'Succès'
                : (launch.success == false ? 'Échec' : 'Statut inconnu'),
            launchImage: Image.network(
              "${launch.links?.patch?.small}",
              height: 100,
            ),
          ),
        ),
      );
    }, childCount: launches.length),
  );
}
