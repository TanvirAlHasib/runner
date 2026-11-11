import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';

class DistanceRunAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DistanceRunAppBar({
    super.key,
    required this.searchEnabled,
    required this.controller,
    required this.onSearchChanged,
    required this.onSearchToggle,
  });

  final bool searchEnabled;
  final TextEditingController controller;

  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchToggle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
      Color(ColorConstraints.splashBackground_0),
      elevation: 3,
      automaticallyImplyLeading: false,

      title: Row(
        spacing: 20,
        children: [
          if (!searchEnabled)
            Text(
              'Runner',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                color: Color(ColorConstraints.buttonColor),
                fontWeight: FontWeight.w800,
              ),
            ),

          if (searchEnabled)
            Expanded(
              child: TextFormField(
                controller: controller,
                autofocus: true,
                onChanged: onSearchChanged,
                cursorColor: Color(ColorConstraints.buttonColor),
                style: TextStyle(
                  color: Color(ColorConstraints.buttonColor),
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search destination location',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: onSearchToggle,
          icon: Icon(
            searchEnabled ? Icons.close : Icons.search,
            color: Color(ColorConstraints.buttonColor),
            size: 25,
          ),
        ),
      ],

      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}
