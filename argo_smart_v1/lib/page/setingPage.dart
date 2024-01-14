import 'package:argo_smart_v1/page/help.dart';
import 'package:argo_smart_v1/page/login_page.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc7f6ce),
        toolbarHeight: 100,
        shape: Border(bottom: BorderSide(color: Colors.black)),
        title: Container(
          width: mediaSize.width,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 78,
                width: 78,
              ),
              Text(
                "Setting",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
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
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 15),
            _buildTextPengaturan(),
            SizedBox(height: 5),
            _buildButtonwifi(context),
            SizedBox(height: 20),
            _buildTextLaporan(),
            SizedBox(height: 5),
            HelpButtn(),
            Spacer(),
            _logoutButton(),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget _buildTextPengaturan() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "    Pengaturan alat",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTextLaporan() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "    Laporan",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildButtonwifi(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () {
            _openDialog(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size(0, 38),
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              const Text(
                "MyESP",
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  _openDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDialog(BuildContext context) async {
    bool isPasswordVisible = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.wifi),
                Text(
                  " Koneksikan ke wifi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 400,
                  height: 80,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nama Wifi',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 400,
                  height: 80,
                  child: TextField(
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 20,
                    shadowColor: Colors.grey,
                    minimumSize: const Size(180, 50),
                    backgroundColor: const Color(0xFF4F6F52),
                  ),
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _logoutButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          LoginPage();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.grey,
          minimumSize: const Size(180, 60),
          backgroundColor: const Color(0xFF4F6F52),
        ),
        child: const Text(
          "Log Out",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
