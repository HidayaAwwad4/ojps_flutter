import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String value;

  const DetailTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[100]!),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
