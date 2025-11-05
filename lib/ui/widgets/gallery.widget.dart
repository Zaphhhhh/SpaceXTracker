import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final List<String> images;

  const Gallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final imageUrl = images[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(imageUrl),
          ),
        );
      }, childCount: images.length),
    );
  }
}
