import 'package:flutter/material.dart';
import 'package:login_ui/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController temail = TextEditingController();
  TextEditingController tpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 15.0, right: 15),
              child: TextField(
                controller: temail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    //errorText: "sdf",
                    label: Text("Email or Mobile No."),
                    fillColor: Colors.grey.shade200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 220),
              child: TextField(
                controller: temail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    //errorText: "sdf",
                    label: Text("Password"),
                    fillColor: Colors.grey.shade200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 245.0, top: 272),
              child:
                  TextButton(onPressed: () {}, child: Text("Forgot Password?")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 350, right: 15),
              child: Container(
                  width: double.infinity,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Login"))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 406),
              child: Text("Don't have account?"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200, top: 390),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SignupPage();
                      },
                    ));
                  },
                  child: Text("Register")),
            ),
          ],
        ),
      )),
    );
  }
}
