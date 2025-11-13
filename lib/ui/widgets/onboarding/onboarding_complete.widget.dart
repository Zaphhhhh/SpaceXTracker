// lib/presentation/widgets/app_onboarding.widget.dart

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'onboarding_tab.widget.dart';

class OnboardingComplete extends StatelessWidget {
  final VoidCallback onDone;

  const OnboardingComplete({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      onDone: onDone,
      onSkip: onDone,
      showSkipButton: true,
      skip: const Text(
        "Passer",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: const Text(
        "Commencer",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.orangeAccent,
        color: Colors.white54,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      globalBackgroundColor: const Color(0xFF1A1A2E).withOpacity(0.95),
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: const OnboardingTab(
            icon: Icons.rocket_launch,
            title: "Bienvenue sur SpaceX Tracker",
            imagePath: 'assets/spacex_placeholder.png',
            description:
                "Visualisez tous les lancements effectués depuis bientôt 20 ans.",
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: const OnboardingTab(
            icon: Icons.grid_view,
            title: "Triez les lancements",
            imagePath: 'assets/filters.png',
            description:
                "Choisissez entre le mode 'grille' et 'liste' selon vos préférences et profitez des filtres et de la recherche afin de trouver ce que vous cherchez.",
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: const OnboardingTab(
            icon: Icons.link,
            title: "Apprenez-en plus !",
            imagePath: 'assets/links.png',
            description:
                "Cliquez sur le lancements souhaité pour en afficher les moindres détails ! Vous pouvez même compléter vos recherche en cliquant sur les liens vers les articles publiés par SpaceX ou encore en regardant les photos du lancement.",
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: const OnboardingTab(
            icon: Icons.favorite_border,
            title: "Gardez Vos Favoris",
            imagePath: 'assets/fav.png',
            description:
                "Ajoutez un lancement à vos favoris pour ne plus jamais le perdre de vue.",
          ),
        ),
      ],
    );
  }
}
