import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TombolTes extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<TombolTes> {
  bool On = false;
  final dbr = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            dbr.child("switch").set({"boolean": !On});
            setState(() {
              On = !On;
            });
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 20,
            shadowColor: Colors.grey,
            minimumSize: const Size(180, 60),
            backgroundColor: const Color(0xFF4F6F52),
          ),
          child: On
              ? Text(
                  "Berhenti",
                  style: const TextStyle(color: Colors.white),
                )
              : Text(
                  "Siram",
                  style: const TextStyle(color: Colors.white),
                )),
    );
  }
}
