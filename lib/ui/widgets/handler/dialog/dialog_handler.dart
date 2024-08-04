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

  Future<void> showExitDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App?'),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child:
                const Text('Yes', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  void pop() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
