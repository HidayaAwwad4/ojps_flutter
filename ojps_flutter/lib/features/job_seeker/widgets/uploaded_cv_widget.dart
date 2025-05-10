import 'package:flutter/material.dart';

class UploadedCvWidget extends StatelessWidget {
  const UploadedCvWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("cv_razan.pdf"),
          Icon(
            Icons.edit,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
