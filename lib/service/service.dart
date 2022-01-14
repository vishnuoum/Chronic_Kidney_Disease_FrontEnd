import 'dart:convert';

import 'package:http/http.dart';

class Service{

  Future<dynamic> classify({required String? age,required String? ba,required String? ane,required String? pe,required String? appet,
    required String? dm, required String? cad, required String? pc, required String? pcc,
    required String? rbc, required String? su, required String? al, required String? sg,
    required String? htn, required String? bp, required String? bgr, required String? bu,
    required String? sc, required String? sod, required String? pot, required String? hemo, required String? pcv,
    required String? wc, required String? rc})async{
    try {
      dynamic response = await post(Uri.parse("http://192.168.18.2:3000/estimate"),
          body: {
            "age": age,
            "ba": ba,
            "ane": ane,
            "pe": pe,
            "appet": appet,
            "dm": dm,
            "cad": cad,
            "pc": pc,
            "pcc": pcc,
            "rbc": rbc,
            "su": su,
            "al": al,
            "sg": sg,
            "htn": htn,
            "bp": bp,
            "bgr": bgr,
            "bu": bu,
            "sc": sc,
            "sod": sod,
            "pot": pot,
            "hemo": hemo,
            "pcv": pcv,
            "wc": wc,
            "rc": rc
          });
      if (response.body == "error") {
        return "error";
      }
      return response.body;
    }
    catch(e){
      print(e);
      return "error";
    }
  }
  
  Future<dynamic> extract({required String? path})async{
    try{
      var request = new MultipartRequest("POST", Uri.parse("http://192.168.18.2:3000/extract"));
      request.files.add(await MultipartFile.fromPath(
        'pic',
        path!,
      ));
      var response=await request.send();
      String body=await response.stream.bytesToString();
      if(body!="error"){
        return jsonDecode(body);
      }
      else{
        return "error";
      }

    }
    catch(e){
      print(e);
      return "netError";
    }
  }
}