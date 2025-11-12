import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/launch.model.dart';
import 'package:spacex_app/ui/pages/details.page.dart';
import 'package:spacex_app/ui/widgets/launch_card.widget.dart';
import 'package:spacex_app/utils/date_formatter.dart';

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

Widget buildSliverList(
  List<Launch> launches,
  Set<String> favoriteIds,
  Function(String) onFavoriteToggle,
) {
  const String placeholderAsset = 'assets/spacex_placeholder.png';
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      final launch = launches[index];
      final isFavorite = favoriteIds.contains(launch.id);
      final imageUrl = launch.links?.patch?.small;
      final imageWidget = (imageUrl != null && imageUrl.isNotEmpty)
          ? Image.network(imageUrl, height: 100)
          : Image.asset(placeholderAsset, height: 100);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contexte) => Details(
                  launch: launch,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () => onFavoriteToggle(launch.id!),
                ),
              ),
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
            launchImage: imageWidget,
            isFavorite: isFavorite,
            onFavoritePressed: () => onFavoriteToggle(launch.id!),
          ),
        ),
      );
    }, childCount: launches.length),
  );
}
