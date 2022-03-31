import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {

  @override
  void initState() {
    init();
    super.initState();
  }

  void init()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("dob")){
      print("yes");
      Future(() => Navigator.pushReplacementNamed(context, "/estimate"));
    }
    else{
      print("no");
      Future(() => Navigator.pushReplacementNamed(context, "/login"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
