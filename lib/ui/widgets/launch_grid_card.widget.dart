import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart'; // Assurez-vous que ce chemin est correct

class LaunchGridCard extends StatelessWidget {
  final String missionName;
  final String launchDate;
  final String succesInfo;
  final Widget launchImage;

  const LaunchGridCard({
    super.key,
    required this.missionName,
    required this.launchDate,
    required this.succesInfo,
    required this.launchImage,
  });

  @override
  Widget build(BuildContext context) {
    // AspectRatio force le widget à être carré
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        // On garde le même style pour la cohérence
        color: const Color(0xFF2A2A4D),
        clipBehavior: Clip
            .antiAlias, // Important pour que les coins de l'image soient arrondis
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.orange.withOpacity(0.8), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            8.0,
          ), // Un peu moins de padding pour ce format compact
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Étire les enfants horizontalement
            children: [
              // --- HAUT : Titre de la mission ---
              Text(
                missionName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),

              // --- MILIEU : Date et Image ---
              Expanded(
                child: Row(
                  children: [
                    // Gauche : Date
                    Expanded(
                      flex: 2, // Donne un peu plus de place au texte
                      child: Text(
                        launchDate,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Droite : Image
                    Expanded(
                      flex: 3, // Donne plus de place à l'image
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: launchImage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // --- BAS : Statut de succès ---
              Align(
                alignment: Alignment.center,
                child: SuccessBubble(successInfo: succesInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
