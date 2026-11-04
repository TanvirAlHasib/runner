import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/screens/home_screen.dart';
import 'package:runner/screens/run_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppRoutes(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/",
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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
