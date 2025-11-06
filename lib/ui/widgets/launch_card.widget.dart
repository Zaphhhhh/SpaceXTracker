import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';

class LaunchCard extends StatelessWidget {
  final String missionName;
  final String launchDate;
  final String succesInfo;
  final Widget launchImage;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const LaunchCard({
    super.key,
    required this.missionName,
    required this.launchDate,
    required this.succesInfo,
    required this.launchImage,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A4D),
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.orange.withOpacity(0.8), width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 30,
                        ),
                        onPressed: onFavoritePressed,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          missionName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    launchDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  SuccessBubble(successInfo: succesInfo),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(width: 100, height: 100, child: launchImage),
            ),
          ],
        ),
      ),
    );
  }
}
