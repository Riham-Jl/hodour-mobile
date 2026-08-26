import 'package:flutter/material.dart';

class AdminBadge extends StatelessWidget {
  final String text;
  final Color color;
  const AdminBadge({required this.text, required this.color, super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12)),
      child: Text(text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 11)));
}
