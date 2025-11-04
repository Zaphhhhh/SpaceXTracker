import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessBubble extends StatelessWidget {
  final String successInfo;

  const SuccessBubble({super.key, required this.successInfo});

  @override
  Widget build(BuildContext context) {
    Color bubbleColor;
    if (successInfo == 'Succès') {
      bubbleColor = Colors.green;
    } else if (successInfo == 'Échec') {
      bubbleColor = Colors.red;
    } else {
      bubbleColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: bubbleColor.withAlpha(100),
        border: Border.all(color: bubbleColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        successInfo,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
