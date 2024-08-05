import 'package:flutter/cupertino.dart';

class SettingButtonModel {
  final String title;
  final IconData icon;
  final Function()? click;
  final Color? color;

  SettingButtonModel(
      {required this.title, required this.icon, this.click, this.color});
}
