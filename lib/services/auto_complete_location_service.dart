import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:runner/constraints/credentials.dart';
import 'package:runner/constraints/urls.dart';

class AutoCompleteLocationService {

  static Future<Response> getAddress(String address) async{
    Response response = await http.post(Uri.parse(Urls.autoCompleteLocationUrl), headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': Credentials.apiKey,
      }, body: jsonEncode({
      'input' : address
      })
    );

    return response;
  }

}