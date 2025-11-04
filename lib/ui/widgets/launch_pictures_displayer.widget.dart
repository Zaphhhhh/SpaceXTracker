import 'package:flutter/cupertino.dart';

import '../../data/models/launch.model.dart';
import 'clickable_image.widget.dart';

class LaunchPicturesDisplayer extends StatelessWidget {
  final Launch launch;
  const LaunchPicturesDisplayer({required this.launch});

  @override
  Widget build(BuildContext context) {
    final List<String> images = launch.links?.flickr?.original ?? [];

    if (images.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        for (final imageUrl in images)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 40,
                ),
                child: Image.network(imageUrl),
              ),
              Text(imageUrl),
            ],
          ),
      ],
    );
  }
}
