import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/models/AutoCompleteLocationModel.dart' hide Text;

class DestinationSearchList extends StatelessWidget {
  const DestinationSearchList({
    super.key,
    required this.predictions,
    required this.onDestinationSelected,
  });

  final List<PlacePrediction?> predictions;

  final ValueChanged<PlacePrediction> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    if (predictions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      left: 12,
      right: 12,

      child: Material(
        color: Color(ColorConstraints.splashBackground_0),
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,

        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),

          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: predictions.length,

            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: Colors.white12,
            ),

            itemBuilder: (context, index) {
              final item = predictions[index];

              return ListTile(
                onTap: () {
                  onDestinationSelected(item!);
                },

                leading: Icon(
                  Icons.location_on_sharp,
                  color: Color(
                    ColorConstraints.headLineFontColor,
                  ),
                ),

                title: Text(
                  item?.text?.text ?? 'Unknown location',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    color: Color(
                      ColorConstraints.headLineFontColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
