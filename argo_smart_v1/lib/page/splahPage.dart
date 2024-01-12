import 'dart:async';

import 'package:argo_smart_v1/page/logTest.dart';
import 'package:argo_smart_v1/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplahPage extends StatelessWidget {
  const SplahPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginPage());
    });
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(),
          Align(
            alignment: Alignment(0, -0.9),
            child: Image(
              image: const AssetImage("assets/images/logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
