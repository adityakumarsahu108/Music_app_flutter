import 'package:flutter/material.dart';

class HeartIcon extends StatefulWidget {
  final Function(bool) onTap;
  final bool isFavorite;

  const HeartIcon({required this.onTap, required this.isFavorite, Key? key})
      : super(key: key);

  @override
  _HeartIconState createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: widget.isFavorite ? Colors.red : Colors.grey,
        size: 30,
      ),
      onTap: () {
        widget.onTap(!widget.isFavorite);
      },
    );
  }
}
