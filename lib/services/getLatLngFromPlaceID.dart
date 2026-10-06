import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:runner/constraints/urls.dart';
import '../constraints/credentials.dart';

class GetLatLngFromPlaceId {

  //get the response
  static Future<LatLng?> getLatLng(String placeID) async{
    Response response = await http.get(
      Uri.parse(Urls.getPlacesByPlaceIdUrl(placeID)),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': Credentials.apiKey,
        "X-Goog-FieldMask": "location",
      }
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      final responseMap = jsonDecode(response.body);
      return LatLng(
        (responseMap["location"]["latitude"] as num).toDouble(),
        (responseMap["location"]["longitude"] as num).toDouble()
      );
    }
    return null;
  }

}