import 'package:flutter/material.dart';

class SwitchCard extends StatelessWidget {
  final String name;
  final TextStyle style;
  final Color color;
  const SwitchCard({
    Key? key,
    required this.name,
    required this.style,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12 / 4,
      ),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: style,
      ),
    );
  }
}
