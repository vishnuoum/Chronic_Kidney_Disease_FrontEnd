import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

class Service{

  Future<dynamic> classify({required String? age,required String? ba,required String? ane,required String? pe,required String? appet,
    required String? dm, required String? cad, required String? pc, required String? pcc,
    required String? al, required String? sg,
    required String? htn, required String? bp, required String? bgr, required String? bu,
    required String? sc, required String? sod, required String? hemo, required String? pcv,
    required String? wc, required String? rc})async{
    try {
      HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      var ioClient = new IOClient(client);
      dynamic response = await ioClient.post(Uri.parse("https://192.168.18.2:3000/estimate"),
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
            "al": al,
            "sg": sg,
            "htn": htn,
            "bp": bp,
            "bgr": bgr,
            "bu": bu,
            "sc": sc,
            "sod": sod,
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
      HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      var ioClient = new IOClient(client);
      var request = new MultipartRequest("POST", Uri.parse("https://192.168.18.2:3000/extract"));
      request.files.add(await MultipartFile.fromPath(
        'pic',
        path!,
      ));
      var response=await ioClient.send(request);
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