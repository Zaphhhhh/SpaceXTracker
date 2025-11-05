import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<TextWrapper> createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 70),
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 18),
              softWrap: true,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        isExpanded
            ? OutlinedButton.icon(
                icon: const Icon(Icons.arrow_upward, color: Colors.orange),
                label: const Text(
                  'Read less',
                  style: TextStyle(color: Colors.orange),
                ),
                onPressed: () => setState(() => isExpanded = false),
              )
            : TextButton.icon(
                icon: const Icon(Icons.arrow_downward, color: Colors.orange),
                label: const Text(
                  'Read more',
                  style: TextStyle(color: Colors.orange),
                ),
                onPressed: () => setState(() => isExpanded = true),
              ),
      ],
    );
  }
}
