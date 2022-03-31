import 'package:ckd_classifier/service/service.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  Service service=Service();

  late SharedPreferences sharedPreferences;
  TextEditingController eMail=TextEditingController(text: ""),password=TextEditingController(text: ""),
  name=TextEditingController(text: ""),repeatPassword=TextEditingController(text: "");

  String? dob="";

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  void load()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  showLoading(BuildContext context){
    AlertDialog alert =AlertDialog(
      content: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,width: 50,child: CircularProgressIndicator(strokeWidth: 5,valueColor: AlwaysStoppedAnimation(Colors.blue),),),
            SizedBox(height: 10,),
            Text("Loading")
          ],
        ),
      ),
    );

    showDialog(context: context,builder:(BuildContext context){
      return WillPopScope(onWillPop: ()async => false,child: alert);
    });
  }


  Future<void> alertDialog(var text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 70,left: 30,right: 30),
            children: [
              Text("Signup",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 60,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DateTimePicker(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Date of Birth"
                  ),
                  initialValue: "",
                  firstDate: DateTime(1945),
                  lastDate: DateTime(2100),
                  onChanged: (val) {
                    setState(() {
                      dob=val;
                    });
                  },
                )
              ),
              SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: eMail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: repeatPassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Repeat Password",
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 12,),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 16),),
                onPressed: ()async{
                  FocusScope.of(context).unfocus();
                  if(dob==null){
                    alertDialog("Something went wrong.");
                    return;
                  }
                  if(eMail.text.length==0 || password.text.length==0 ||repeatPassword.text.length==0||name.text.length==0||dob!.length==0){
                    alertDialog("Please complete the form");
                    return;
                  }
                  if(calculateAge(DateTime.parse(dob.toString()))<18){
                    alertDialog("You must be at least 18 years old.");
                    return;
                  }
                  if(password.text!=repeatPassword.text){
                    alertDialog("Passwords doesn't match");
                    return;
                  }
                  if(password.text.length<8){
                    alertDialog("Password must be of at least 8 characters in length");
                    return;
                  }
                  if(!validateStructure(password.text)){
                    alertDialog("Password must be a combination of uppercase, lowercase and special characters (@,\$,!,#,&,* allowed)");
                    return;
                  }
                  showLoading(context);
                  print(dob);
                  dynamic result=await service.signup(mail: eMail.text, name:name.text, password: password.text,dob: dob);
                  print(result);
                  if(result=="done"){
                    Navigator.pop(context);
                    sharedPreferences.setString("dob", dob.toString());
                    Navigator.pushReplacementNamed(context, "/estimate");
                  }
                  else{
                    Navigator.pop(context);
                    alertDialog("Something went wrong. Try again later.");
                  }
                },
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Text("Already a User? Login!!!",style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
