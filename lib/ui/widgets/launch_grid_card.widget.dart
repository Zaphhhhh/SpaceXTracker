import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';

class LaunchGridCard extends StatelessWidget {
  final String missionName;
  final String launchDate;
  final String succesInfo;
  final Widget launchImage;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const LaunchGridCard({
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
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        color: const Color(0xFF2A2A4D),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.orange.withOpacity(0.8), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                  Expanded(
                    child: Text(
                      missionName,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
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
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: launchImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

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
