import 'package:ckd_classifier/service/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EstimatePage extends StatefulWidget {
  const EstimatePage({Key? key}) : super(key: key);

  @override
  _EstimatePageState createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  
  Service service=Service();
  final ImagePicker _picker = ImagePicker();

  String? ba="Select an option",ane="Select an option",pe="Select an option",appet="Select an option",dm="Select an option",cad="Select an option",pc="Select an option",pcc="Select an option",al="Select an option",sg="Select an option",htn="Select an option";
  String? baVal="Select an option",aneVal="Select an option",peVal="Select an option",appetVal="Select an option",dmVal="Select an option",cadVal="Select an option",pcVal="Select an option",pccVal="Select an option",rbcVal="Select an option",suVal="Select an option",alVal="Select an option",sgVal="Select an option",htnVal="Select an option";
  TextEditingController age=TextEditingController(),
      bp=TextEditingController(),
      bgr=TextEditingController(),
      bu=TextEditingController(),
      sc=TextEditingController(),
      sod=TextEditingController(),
      hemo=TextEditingController(),
      pcv=TextEditingController(),
      wc=TextEditingController(),
      rc=TextEditingController();
  
  void reset(){
    ba="Select an option";
    ane="Select an option";
    pe="Select an option";
    appet="Select an option";
    dm="Select an option";
    cad="Select an option";
    pc="Select an option";
    pcc="Select an option";
    al="Select an option";
    sg="Select an option";
    htn="Select an option";
    bp.clear();
    bgr.clear();
    bu.clear();
    age.clear();
    sc.clear();
    sod.clear();
    hemo.clear();
    pcv.clear();
    wc.clear();
    rc.clear();
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

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  void extract(Map values){
    print(values);
    if(values.containsKey("BP")){
      bp.text=values["BP"];
    }
    if(values.containsKey("SG")){
      if(["1.005", "1.010", "1.015", "1.020", "1.025"].contains(values["SG"])) {
        sg = values["SG"];
        sgVal = values["SG"];
      }
    }
    if(values.containsKey("ALBUMIN")){
      if(["0", "1", "2", "3", "4", "5"].contains(values["ALBUMIN"])) {
        al = values["ALBUMIN"];
        alVal = values["ALBUMIN"];
      }
    }
    if(values.containsKey("PC")){
      if(["Normal", "Abnormal"].contains(values["PC"])) {
        pc = values["PC"];
        pcVal = values["PC"] == "Normal" ? "0" : "1";
      }
    }
    if(values.containsKey("PCC")){
      if(["Present", "Not"].contains(values["PCC"]))
      pcc=values["PCC"]=="Not"?"Not Present":"Present";
      pccVal=values["PCC"]=="Not"?"0":"1";
    }
    if(values.containsKey("BGR")){
      if(isNumeric(values["BGR"]))
        bgr.text=values["BGR"];
    }
    if(values.containsKey("SC")){
      if(isNumeric(values["SC"]))
        sc.text=values["SC"];
    }
    if(values.containsKey("BU")){
      if(isNumeric(values["BU"]))
        bu.text=values["BU"];
    }
    if(values.containsKey("SODIUM")){
      if(isNumeric(values["SODIUM"]))
        sod.text=values["SODIUM"];
    }
    if(values.containsKey("HB")){
      if(isNumeric(values["HB"]))
        hemo.text=values["HB"];
    }
    if(values.containsKey("PCV")){
      if(isNumeric(values["BGR"]))
        pcv.text=values["PCV"];
    }
    if(values.containsKey("WBC")){
      if(isNumeric(values["WBC"]))
        wc.text=values["WBC"];
    }
    if(values.containsKey("RBC")){
      if(isNumeric(values["RBC"]))
        rc.text=values["RBC"];
    }
    setState(() {

    });
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
            padding: EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 30),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CKD Classifier",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/ckd");
                        },
                        child: Icon(Icons.info_outline,size: 15,color: Colors.blue,),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: ()async{
                        // Capture a photo
                        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                        print(photo!.path);
                        showLoading(context);
                        var values=await service.extract(path: photo.path);
                        Navigator.pop(context);
                        extract(values);
                      }, icon: Icon(Icons.camera_alt),color: Colors.blue,tooltip: "Open Camera",),
                      IconButton(onPressed: ()async{
                        // Pick an image
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        print(image!.path);
                        showLoading(context);
                        var values=await service.extract(path: image.path);
                        Navigator.pop(context);
                        if(values=="error"){
                          alertDialog("Something went wrong with OCR");
                        }
                        else if(values=="netError")
                          alertDialog("Please check your network connection and Try again.");
                        else
                          extract(values);
                      }, icon: Icon(Icons.photo),color: Colors.blue,tooltip: "Select from Gallery",),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              Text("Age"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Age",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Blood Pressure"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: bp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Blood Pressure",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Specific Gravity"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: sg,
                  items: <String>["Select an option","1.005", "1.010", "1.015", "1.020", "1.025"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        sg = val;
                        sgVal=val;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Albumin"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: al,
                  items: <String>["Select an option","0", "1", "2", "3", "4", "5"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        al = val;
                        alVal=val;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Pus Cell"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: pc,
                  items: <String>["Select an option","Normal", "Abnormal"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        pc = val;
                        pcVal = val=="Normal"?"0":"1";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Pus Cell Clamps"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: pcc,
                  items: <String>["Select an option","Present", "Not Present"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        pcc = val;
                        pccVal = val=="Present"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Bacterial Infection"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: ba,
                  items: <String>["Select an option","Yes", "No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        ba = val;
                        baVal = val=="Yes"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Glucose Random"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: bgr,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Blood Glucose Random",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Blood Urea Level"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: bu,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Blood Urea",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Serum Creatine"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: sc,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Serum Creatine",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Sodium Level"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: sod,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Sodium",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Haemoglobin"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: hemo,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Hemoglobin",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Packed Cell Volume"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: pcv,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Packed Cell Volume",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("White Blood Cell Count"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: wc,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "WBC Count",
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 12,),
              Text("Red Blood Cell Count"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: rc,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "RBC Count",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text("Hyper Tension?"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: htn,
                  items: <String>["Select an option","Yes", "No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        htn = val;
                        htnVal = val=="Yes"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Diabetes Mellitus"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: dm,
                  items: <String>["Select an option","Yes", "No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        dm = val;
                        dmVal = val=="Yes"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Coronary Artery Disease"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: cad,
                  items: <String>["Select an option","Yes", "No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        cad = val;
                        cadVal = val=="Yes"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Appetite"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: appet,
                  items: <String>["Select an option","Good", "Poor"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        appet = val;
                        appetVal = val=="Good"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Pedal Edema"),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: pe,
                  items: <String>["Select an option","Yes", "No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if(val!="Select an option") {
                      setState(() {
                        pe = val;
                        peVal = val=="Yes"?"1":"0";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12,),
              Text("Anemia"),
              SizedBox(height: 5,),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: ane,
                    items: <String>["Select an option","Yes", "No"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: value=="Select an option"?Colors.grey[700]:Colors.black),),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if(val!="Select an option") {
                        setState(() {
                          ane = val;
                          aneVal = val=="Yes"?"1":"0";
                        });
                      }
                    },
                  ),
                ),
              SizedBox(height: 20,),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: Text("Classify",style: TextStyle(color: Colors.white,fontSize: 16),),
                onPressed: ()async{
                  FocusScope.of(context).unfocus();
                  if(ba=="Select an option"||ane=="Select an option"||pe=="Select an option"||appet=="Select an option"||
                      dm=="Select an option"||cad=="Select an option"||pc=="Select an option"||pcc=="Select an option"||
                      al=="Select an option"||sg=="Select an option"||
                      htn=="Select an option"||bp.text==""||bgr.text==""||
                      bu.text==""||sc.text==""||sod.text==""||
                      hemo.text==""||pcv.text==""||
                      wc.text==""||rc.text==""||age.text==""){
                        alertDialog("Please fill up the form");
                  }
                  else{
                    showLoading(context);
                    var result=await service.classify(age: age.text, ba: baVal, ane: aneVal, pe: peVal, appet: appetVal, dm: dmVal, cad: cadVal, pc: pcVal, pcc: pccVal, al: alVal, sg: sgVal, htn: htnVal, bp: bp.text, bgr: bgr.text, bu: bu.text, sc: sc.text, sod: sod.text, hemo: hemo.text, pcv: pcv.text, wc: wc.text, rc: rc.text);
                    Navigator.pop(context);
                    if(result=="ckd"){
                      alertDialog("You are diagnosed with Chronic Kidney Disease. Please visit the nearest hospital for treatment.");
                    }
                    else if(result=="notckd"){
                      alertDialog("Chronic Kidney Disease not detected");
                    }
                    else{
                      alertDialog("Something went wrong. Please try again later.");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
