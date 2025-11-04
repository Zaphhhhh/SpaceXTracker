import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacex_app/ui/widgets/succes_bubble.widget.dart';

class LaunchCard extends StatelessWidget {
  final String missionName;
  final String launchDate;
  final String succesInfo;
  final Widget launchImage;

  const LaunchCard({
    super.key,
    required this.missionName,
    required this.launchDate,
    required this.succesInfo,
    required this.launchImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A4D),
      margin: const EdgeInsets.only(bottom: 16.0),
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
                  Text(
                    missionName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const SizedBox(height: 8), launchImage],
            ),
          ],
        ),
      ),
    );
  }
}
