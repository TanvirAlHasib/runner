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
  final _formKey = GlobalKey<FormState>();
  String activeField = "";
  List<PlacePrediction> predictedPlaces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
          child: Form(
            key: _formKey,
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
                  onTap: () => activeField = "from",
                  onChanged: (value) async {
                    if (value.isEmpty) {
                      setState(() {
                        predictedPlaces.clear();
                      });
                      return;
                    }

                    Response response = await AutoCompleteLocationService.getAddress(value);

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      final responseMap = jsonDecode(response.body);

                      final autoCompleteLocation = AutoCompleteLocationModel.fromJson(responseMap);

                      predictedPlaces.clear();

                      for (final suggestion in autoCompleteLocation.suggestions ?? []) {
                        if (suggestion.placePrediction != null) {
                          predictedPlaces.add(suggestion.placePrediction!);
                        }
                      }

                      setState(() {});
                    }
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
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Can not be empty";
                    }
                    return null;
                  },
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
                  onTap: () => activeField = "to",
                  onChanged: (value) async {
                    if (value.isEmpty) {
                      setState(() {
                        predictedPlaces.clear();
                      });
                      return;
                    }
                    
                    Response response = await AutoCompleteLocationService.getAddress(value);
                    if(response.statusCode == 200 || response.statusCode == 201){
                      final responseMap = jsonDecode(response.body);
                      final autoCompleteLocations = AutoCompleteLocationModel.fromJson(responseMap);
                      predictedPlaces.clear();
                      for(final suggestions in autoCompleteLocations.suggestions ?? []){
                        predictedPlaces.add(suggestions.placePrediction);
                      }
                      setState(() {});

                      print(predictedPlaces[0].text?.text);
                    }
                    
                  },
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
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Can not be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                // here is predicted places list will show
                Expanded(
                  child: ListView.builder(
                    itemCount: predictedPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if(activeField.contains("from")){
                            fromLocation.text = "${predictedPlaces[index].text?.text}";
                          } else{
                            toLocation.text = "${predictedPlaces[index].text?.text}";
                          }
                          // updating the state and predictedPlaces
                          setState(() {
                            predictedPlaces.clear();
                          });
                        },
                        leading: Icon(Icons.location_on_sharp, color: Color(ColorConstraints.headLineFontColor),),
                        title: Text("${predictedPlaces[index].text?.text}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(ColorConstraints.headLineFontColor)
                        ),),
                      );
                    },
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(),));
                      }
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
