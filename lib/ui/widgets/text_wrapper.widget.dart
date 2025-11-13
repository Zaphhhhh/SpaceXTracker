import 'package:flutter/material.dart';

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<TextWrapper> createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper> {
  bool isExpanded = false;
  static const double collapsedHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: const TextStyle(fontSize: 18),
          ),
          textDirection: TextDirection.ltr,
          maxLines: null,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        final bool isTextOverflowing =
            textPainter.size.height > collapsedHeight;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: isExpanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: collapsedHeight),
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            if (isTextOverflowing)
              isExpanded
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.orange,
                      ),
                      label: const Text(
                        'Replier',
                        style: TextStyle(color: Colors.orange),
                      ),
                      onPressed: () => setState(() => isExpanded = false),
                    )
                  : TextButton.icon(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.orange,
                      ),
                      label: const Text(
                        'Lire la suite',
                        style: TextStyle(color: Colors.orange),
                      ),
                      onPressed: () => setState(() => isExpanded = true),
                    ),
          ],
        );
      },
    );
  }
}
