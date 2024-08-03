import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogHandler {
  final BuildContext context;

  DialogHandler(this.context);

  Future<void> showLoadingDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: SpinKitSquareCircle(
          color: Colors.blueAccent,
          size: 32,
        ),
      ),
    );
  }

  void pop() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
