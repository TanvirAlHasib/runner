import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/screens/map_screen.dart';
import '../constraints/color_constraints.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  bool flagRun = true;
  bool flagDistance = false;
  bool flagTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myAppBar(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(
                      height: 370,
                      child: Stack(
                        alignment: AlignmentGeometry.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadiusGeometry.all(Radius.circular(10)),
                            child: GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(37.42796133580664, -122.085749655962),
                                zoom: 14.4746,
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: .min,
                              spacing: 3,
                              children: [
                                Icon(Icons.fiber_manual_record, color: Color(ColorConstraints.buttonColor), size: 16,),
                                Text("On Track", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text("Run Goals", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Color(ColorConstraints.headLineFontColor),
                        fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(
                      height: 18,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StatefulBuilder(
                        builder: (
                            BuildContext context,
                            void Function(void Function()) setState) {
                          return Row(
                            spacing: 8,
                            children: [
                              InkWell(
                                  onTap:() {
                                    setState((){
                                      flagRun = true;
                                      flagDistance = false;
                                      flagTime = false;
                                    });
                                  },
                                  child: runGoals(
                                    "lib/assets/icons/run.svg",
                                    "Free Run", context,
                                    flagRun ? Color(ColorConstraints.backGroundColor) : Colors.grey.shade900, // for backGround
                                    flagRun ? Color(ColorConstraints.buttonColor) : Colors.grey.shade400, // for icon
                                    flagRun ? Color(ColorConstraints.buttonColor) : Color(ColorConstraints.headLineFontColor), // for font color
                                  )
                              ),
                              InkWell(
                                  onTap:() {
                                    setState((){
                                      flagRun = false;
                                      flagDistance = true;
                                      flagTime = false;
                                    });
                                  },
                                  child: runGoals(
                                    "lib/assets/icons/route.svg",
                                    "Distance", context,
                                    flagDistance ? Color(ColorConstraints.backGroundColor) : Colors.grey.shade900,
                                    flagDistance ? Color(ColorConstraints.buttonColor) : Colors.grey.shade400,
                                    flagDistance ? Color(ColorConstraints.buttonColor) : Color(ColorConstraints.headLineFontColor),
                                  )
                              ),
                              InkWell(
                                  onTap:() {
                                    setState((){
                                      flagRun = false;
                                      flagDistance = false;
                                      flagTime = true;
                                    });
                                  },
                                  child: runGoals(
                                    "lib/assets/icons/timer.svg",
                                    "Time", context,
                                    flagTime ? Color(ColorConstraints.backGroundColor) : Colors.grey.shade900,
                                    flagTime ? Color(ColorConstraints.buttonColor) : Colors.grey.shade400,
                                    flagTime ? Color(ColorConstraints.buttonColor) : Color(ColorConstraints.headLineFontColor),
                                  )
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
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

  // run goals
  Widget runGoals(
      String iconLocation,
      String title,
      BuildContext context,
      Color backGroundColor, Color forGroundColor, Color fontColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        children: [
          SvgPicture.asset(
            iconLocation,
            height: 30,
            colorFilter: ColorFilter.mode(forGroundColor, BlendMode.srcIn),
          ),
          Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: fontColor,
              fontWeight: FontWeight.w800
          ),)
        ],
      ),
    );
  }
}

