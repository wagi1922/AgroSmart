import 'package:flutter/material.dart';

class SchdulingPage extends StatelessWidget {
  const SchdulingPage({Key? key}); // hapus super. di sini

  @override
  Widget build(BuildContext context) {
    // tambahkan variabel ini
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffc7f6ce),
          toolbarHeight: 100,
          shape: Border(bottom: BorderSide(color: Colors.black)),
          title: Container(
            width: mediaSize.width, // ubah baris ini
            height: 100, // ubah baris ini
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // ubah baris ini
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 78,
                  width: 78,
                ), // tambahkan koma di sini
                Text(
                  "Schduling",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration:
                        TextDecoration.underline, // tambahkan properti ini
                  ),
                ),
                SizedBox(
                  width: 60,
                )
              ],
            ),
          ),
        ),
        body: Container(
          width: 400,
          height: 800,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xffc7f6ce), Color(0x00c9e2cd)],
          )),
        ));
  }
}
