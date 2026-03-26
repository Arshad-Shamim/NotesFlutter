import "dart:async";
import "dart:convert";

import "package:http/http.dart" as http;

class ApiService{

  static Future<String> generateQuestion({required String url_p, required String title, required String desc}) async{
    
    Uri url = Uri.parse(url_p);
    String data = ''' {
                        "contents": [
                          {
                            "parts": [
                              {
                                "text": "Generate 5 important exam questions from these notes: $desc"
                              }
                            ]
                          }
                        ]
                      }
                  ''';
    final res = await http.post(
      url,
      headers: {"Content-Type":"application/json"},
      body: data
    );

    if(res.statusCode==200){
      return res.body;
    }else{
      print("sever error");
      return "";
    }
  }
}