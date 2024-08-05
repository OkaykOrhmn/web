import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class PrimaryGroupButton extends StatefulWidget {
  final List<String> btns;
  final Function(String, int, bool)? onSelected;
  const PrimaryGroupButton({super.key, required this.btns, this.onSelected});

  @override
  State<PrimaryGroupButton> createState() => _PrimaryGroupButtonState();
}

class _PrimaryGroupButtonState extends State<PrimaryGroupButton> {
  final controller = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
        child: GroupButton(
          controller: controller,
          options: GroupButtonOptions(
            borderRadius: BorderRadius.circular(12),
            alignment: Alignment.center,
            buttonHeight: 32,
            crossGroupAlignment: CrossGroupAlignment.center,
            direction: Axis.horizontal,
            groupingType: GroupingType.row,
            runSpacing: 4,
            selectedColor: Colors.blueAccent,
            selectedTextStyle: const TextStyle(color: Colors.white),
            unselectedColor: const Color(0xffeef1f1),
            // unselectedTextStyle: Theme.of(context)
            //     .textTheme
            //     .navbarTitle
            //     .copyWith(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
            textPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          isRadio: true,
          onSelected: widget.onSelected,
          buttons: widget.btns,
        ),
      ),
    );
  }
}
