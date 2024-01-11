import 'package:flutter/material.dart';

class TombolTes extends StatelessWidget {
  const TombolTes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.grey,
          minimumSize: const Size(180, 60),
          backgroundColor: const Color(0xFF4F6F52),
        ),
        child: const Text(
          "SIRAM",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
