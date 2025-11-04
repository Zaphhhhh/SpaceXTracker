import 'package:flutter/material.dart';
import 'package:spacex_app/ui/pages/home_page.page.dart';

import 'data/api/spacex.service.dart';
import 'data/models/launch.model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Launches',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark, // <--- Le changement est ici
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Lancements SpaceX'),
    );
  }
}
