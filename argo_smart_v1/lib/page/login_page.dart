/// Imports the dart:ui library which contains APIs for building user interfaces and 2D graphics.
import 'dart:ui';
import 'package:argo_smart_v1/nafigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPassword = false;
  bool _isLoginFailed = false;

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        _isLoginFailed = false;
      });
      // If authentication is successful, navigate to the next screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return NavBar();
      }));
    } catch (error) {
      setState(() {
        _isLoginFailed = true;
      });
      // If authentication fails, handle the error
      print('Error signing in: $error');
      // You can display an error message or take other actions based on the error
    }
  }

  late Color myColor;
  late Size mediaSize;
  bool rememberUser = false;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      width: 1353,
      height: 904,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: mediaSize.width,
            height: mediaSize.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.9),
            child: Image(
              image: const AssetImage("assets/images/logo.png"),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.09000000357627869),
            body:
                Stack(children: [Positioned(bottom: 0, child: _buildBottom())]),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildForm(),
          )),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Datang!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.50,
          ),
        ),
        Container(
          color: Colors.transparent,
          width: 250,
          child: Text(
            "Masukan akun anda dan mulai rawat kebun anda!",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _TextInputEmail(emailController),
        const SizedBox(height: 13),
        _TextInputPass(passwordController, isPassword: true),
        _rememberForget(),
        const SizedBox(height: 5),
        _loginButton(),
        SizedBox(height: 20),
        if (_isLoginFailed) // Tambahkan widget Text hanya jika login gagal
          Text(
            '    Email atau password salah. Silakan coba lagi.',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget _TextInputEmail(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller, // Pass the controller here
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email Anda',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: myColor, // Warna border saat input difokuskan
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: controller.text.isEmpty ? Colors.grey : Colors.red,
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
      ),
    );
  }

  Widget _TextInputPass(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller, // Pass the controller here
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password Anda',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: myColor, // Warna border saat input difokuskan
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: controller.text.isEmpty ? Colors.grey : Colors.red,
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        suffixIcon: isPassword
            ? IconButton(
                icon: _isPassword
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPassword = !_isPassword;
                  });
                },
              )
            : null,
      ),
      obscureText: !_isPassword,
    );
  }

  Widget _rememberForget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            Text(
              "Ingat saya",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Lupa Sandi?",
              style: TextStyle(color: Colors.lightBlue),
            ))
      ],
    );
  }

  Widget _loginButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Check if email and password are not empty before attempting to sign in
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            signUserIn();
          } else {
            print('Please enter both email and password');
            // You can add a return statement here to exit the onPressed callback
            return;
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.grey,
          minimumSize: const Size(180, 60),
          backgroundColor: const Color(0xFF4F6F52),
        ),
        child: const Text(
          "LOGIN",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
