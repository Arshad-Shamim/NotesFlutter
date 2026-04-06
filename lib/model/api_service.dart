import "dart:async";
import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

class ApiService{

  static Future<http.Response> generateQuestion({required String url_p, required String title, required String desc}) async{
    
    Uri url = Uri.parse(url_p);
    String data = ''' {
                        "contents": [
                          {
                            "parts": [
                              {
                                "text": "Generate important possiable questions and a short hint for each based on the notes and title provided. \n\nOutput Rules:\n1. Enclose EVERY question-hint pair in square brackets [ ].\n2. Inside the brackets, separate the question from the hint using a pipe symbol (|).\n3. Do NOT include numbers, bullet points, or any other text.\n\nRequired Format: [Question 1|Hint 1][Question 2|Hint 2]\n\nNotes: $desc, Title: $title"
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

    return res;
  }

  static Future<String> SignUp({required Map<String,String>formData}) async{
    Map<String,Map<String,String>> body= {"form":formData};

    final url = Uri.parse("https://lockit-server.vercel.app/user/signup/store");

    final res = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        "Content-Type":"application/json"
      }
    );

    if(res.statusCode!=200){
      print(res.body);
    }

    return res.body;

  }

    static Future<String> Signin({required String username, required String password}) async{

    final url = Uri.parse("https://lockit-server.vercel.app/user/signin/authenticate");

    final res = await http.get(
      url,
      headers: {
        "Content-Type":"application/json",
        "username":username,
        "pws":password
      }
    );

    if(res.statusCode!=200){
      print(res.body);
    }

    return res.body;

  }
}