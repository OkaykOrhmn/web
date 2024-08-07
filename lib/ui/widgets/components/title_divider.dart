import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  final Function()? click;
  const TitleDivider({super.key, required this.title, this.click});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          click == null
              ? const SizedBox()
              : InkWell(
                  onTap: click,
                  child: const Text(
                    "See all",
                    style: TextStyle(color: Colors.blueAccent),
                  ))
        ],
      ),
    );
  }
}
