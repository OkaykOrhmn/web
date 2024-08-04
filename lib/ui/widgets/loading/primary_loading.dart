import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryLoading extends StatelessWidget {
  const PrimaryLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitSquareCircle(
        color: Colors.blueAccent,
        size: 32,
      ),
    );
  }
}
