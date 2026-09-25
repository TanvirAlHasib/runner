import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:runner/models/AutoCompleteLocationModel.dart' hide Text;
import 'package:runner/services/auto_complete_location_service.dart';
import '../constraints/color_constraints.dart';
import 'map_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  final TextEditingController fromLocation = TextEditingController();
  final TextEditingController toLocation = TextEditingController();
  List<PlacePrediction> predictedPlaces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("Select Locations", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Color(ColorConstraints.headLineFontColor)
              ),),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                onChanged: (value) async {
                  Response response = await AutoCompleteLocationService.getAddress(value);
                  if(response.statusCode == 200 || response.statusCode == 201){
                    final responseMap = jsonDecode(response.body);
                    for(Map<String, dynamic> singlePrediction in responseMap){
                      predictedPlaces.add(PlacePrediction.fromJson(singlePrediction));
                    }
                  }
                  setState(() {});
                },
                cursorColor: Color(ColorConstraints.buttonColor),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(ColorConstraints.bodyFontColor)
                ),
                controller: fromLocation,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    // user current location will be fetched here
                  }, icon: Icon(Icons.my_location)),
                  suffixIconColor: Color(ColorConstraints.buttonColor),
                  hintText: "From...",
                ),
              ),

              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Icon(Icons.arrow_downward, color: Color(ColorConstraints.buttonColor),),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              TextFormField(
                cursorColor: Color(ColorConstraints.buttonColor),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(ColorConstraints.bodyFontColor)
                ),
                controller: toLocation,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  hintText: "To...",
                  suffixIcon: Icon(Icons.location_on_rounded, color: Color(ColorConstraints.bodyFontColor),)
                ),
              ),

              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(),));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(58),
                      backgroundColor: Color(ColorConstraints.buttonColor),
                      foregroundColor: Color(ColorConstraints.buttonFontColor),
                      textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w800
                      )
                  ),
                  child: Text("Start Run")
              ),
            ],
          ),
        ),
      ),
    );
  }

  // app bar code
  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      elevation: 3,
      title: Text("Runner", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Color(ColorConstraints.buttonColor),
          fontWeight: FontWeight.w800
      ),),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, color: Color(ColorConstraints.buttonColor)),
        )
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }
}
