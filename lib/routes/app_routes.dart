import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/models/run_details_model.dart';
import 'package:runner/screens/home_screen.dart';
import 'package:runner/screens/run_complete_preview.dart';
import 'package:runner/screens/run_screen.dart';
import 'package:runner/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    // for splash screen
    GoRoute(
      path: "/",
      name: "splash",
      builder: (context, state) => SplashScreen(),
    ),
    // for stateful bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppRoutes(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/home",
              name: "home",
              builder: (context, state) => HomeScreen(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/run",
              name: "run",
              builder: (context, state) => RunScreen(),
              routes: [
                GoRoute(
                  path: "preview",
                  name: "preview",
                  builder: (context, state) {
                    final runDetails = state.extra as RunDetailsModel;
                    return RunCompletePreview(runDetailsModel: runDetails);
                  },
                ),
              ]
            )
          ]
        )
      ]
    )
  ]
);

// wrapper stateless widget of the screens
class AppRoutes extends StatelessWidget {
  const AppRoutes({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationShell.currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop && navigationShell.currentIndex != 0){
          navigationShell.goBranch(0);
        }
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(ColorConstraints.backGroundColor),
          currentIndex: navigationShell.currentIndex,
          onTap: (value) {
            navigationShell.goBranch(value);
          },
          selectedFontSize: 15,
          selectedItemColor: Color(ColorConstraints.buttonColor),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w700
          ),
          showUnselectedLabels: false,
          unselectedItemColor: Color(ColorConstraints.bodyFontColor),
          unselectedIconTheme: IconThemeData(
            size: 26
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined),
              activeIcon: Icon(Icons.run_circle),
              label: "Run",
            )
          ],
        ),
      ),
    );
  }
}
