import 'package:flutter/material.dart';

class HelpButtn extends StatefulWidget {
  @override
  _HelpButton createState() => _HelpButton();
}

class _HelpButton extends State<HelpButtn> {
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(width: 15),
                Icon(
                  Icons.help_center,
                  color: Colors.black,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Bantuan & dukungan",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 105),
                IconButton(
                  icon: Icon(
                    hide ? Icons.arrow_drop_down : Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Toggle the value of hide and trigger a rebuild
                    setState(() {
                      hide = !hide;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(width: 50),
            Visibility(
              visible: hide,
              child: _buildColum(),
            )
          ],
        )
      ],
    );
  }

  Widget _buildColum() {
    return Column(
      children: [
        SizedBox(height: 5),
        _buildButtonlayanan(context),
        SizedBox(height: 5),
        _buildButtonlaporkan(context)
      ],
    );
  }

  Widget _buildButtonlayanan(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () {},
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
                Icons.help_center_outlined,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              const Text("Layanan Pengaduan",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonlaporkan(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () {},
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
                Icons.warning,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              const Text("Laporkan Masalah",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
