import 'package:flutter/material.dart';
import 'package:login_ui/homepage.dart';
import 'package:login_ui/loginpage.dart';
import 'package:login_ui/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gonext();
  }

  gonext() async {

    Utils.prefs = await SharedPreferences.getInstance();
    bool loginstatus =await Utils.prefs!.getBool("loginstatus") ?? false;

    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return loginstatus?HomePage():LoginPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading....-"),
      ),
    );
  }
}
