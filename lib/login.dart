import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/home.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  void checkUser() {
    final box = GetStorage();
    String? username = box.read('username');
    if (username != null) {
      print("LOGIN USER ${username}");

      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => HomePage()),
        );
      });
    }
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username != 'admin' || password != 'admin') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username atau Password Salah"),
        ),
      );
      return;
    }
    final box = GetStorage();
    box.write('username', username);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Silahkan\nLogin",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xFF323232),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AppTextField(label: "Username", controller: usernameController),
            const SizedBox(
              height: 20,
            ),
            AppTextField(label: "Password", controller: passwordController),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              text: "Login",
              color: Color(0xFF323232),
              onPressed: () {
                login();
              },
            )
          ],
        ),
      ),
    );
  }
}
