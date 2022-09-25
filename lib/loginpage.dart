import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/homepage.dart';
import 'package:login_ui/signuppage.dart';
import 'package:login_ui/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tusername = TextEditingController();
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
                controller: tusername,
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
                controller: tpass,
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
                      ElevatedButton(onPressed: () async {
                        String username=tusername.text;
                        String pass=tpass.text;

                        Response response = await Dio().get('https://learnwithproject.000webhostapp.com/login/web_view.php?username=$username&pass=$pass');
                        print(response.data);

                        Map map=jsonDecode(response.data);
                        int result=map['result'];

                        if(result==0){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Username or Password")));
                        }
                        else if(result==1){
                          Map userdata = map['userdata'];
                          User user = User.fromJson(userdata);
                          await Utils.prefs!.setBool('loginstatus', true);

                          await Utils.prefs!.setString('id', user.id!);
                          await Utils.prefs!.setString('name', user.name!);
                          await Utils.prefs!.setString('email', user.email!);
                          await Utils.prefs!.setString('contact', user.contact!);
                          await Utils.prefs!.setString('password', user.pass!);
                          await Utils.prefs!.setString('imagepath', user.imagename!);
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));

                      }, child: Text("Login"))),
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


class User {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? pass;
  String? imagename;

  User(
      {this.id,
        this.name,
        this.email,
        this.contact,
        this.pass,
        this.imagename});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    pass = json['pass'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['pass'] = this.pass;
    data['imagename'] = this.imagename;
    return data;
  }
}
