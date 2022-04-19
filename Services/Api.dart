import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class Api{

  dynamic ApiCallingWithRequestBody(String url,var requestbody) async{
    try {
      String username = "admin";
      String password = "admin";
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var res = await http.post(
          Uri.parse("https://bengalhomeservices.com/"+url), headers: <String, String>{'authorization': basicAuth},
          body: requestbody);
      if(res.statusCode==200){
        return json.decode(res.body);
      }else{
        return "Something goes wrong";
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }
  dynamic ApiCallingWithoutRequestBody(String url) async{
    try {
      String username = "admin";
      String password = "admin";
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var res = await http.post(
        Uri.parse("https://bengalhomeservices.com/"+url), headers: <String, String>{'authorization': basicAuth},
      );
      if(res.statusCode==200){
        print(json.decode(res.body));
        return json.decode(res.body);
      }else{
        return "Something goes wrong";
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }
}