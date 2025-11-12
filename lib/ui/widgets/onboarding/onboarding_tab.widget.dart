// lib/presentation/widgets/onboarding_tab.widget.dart

import 'package:flutter/material.dart';

class OnboardingTab extends StatelessWidget {
  final IconData icon;
  final String imagePath;
  final String title;
  final String description;

  const OnboardingTab({
    super.key,
    required this.icon,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Cette structure est la plus robuste car elle ne dépend pas des contraintes du parent.
    // Elle calcule sa propre taille et devient scrollable si nécessaire.
    return SingleChildScrollView(
      child: Padding(
        // On ajoute un padding vertical pour centrer visuellement le contenu
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // La colonne prend la taille minimale nécessaire
          children: <Widget>[
            Icon(icon, size: 100, color: Colors.orangeAccent),
            const SizedBox(height: 20),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 30),

            Image.asset(
              imagePath,
              // On utilise MediaQuery pour donner une hauteur relative à l'écran,
              // ce qui est une bonne pratique.
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
