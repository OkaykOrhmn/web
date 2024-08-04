import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultPlaceHolder extends StatelessWidget {
  final Widget child;

  const DefaultPlaceHolder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffc3c6c6),
      highlightColor: const Color(0xffd6d9d9),
      child: child,
    );
  }
}
