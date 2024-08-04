import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web/core/enum/dialogs_status.dart';

class SnackBarHandler {
  final BuildContext context;

  SnackBarHandler(this.context);

  show(String message, DialogStatus status, bool isTop) {
    Color border = Colors.white;
    switch (status) {
      case DialogStatus.success:
        border = Colors.greenAccent;
        break;

      case DialogStatus.error:
        border = Colors.redAccent;
        break;

      case DialogStatus.info:
        border = Colors.blueAccent;
        break;

      case DialogStatus.warning:
        border = Colors.orangeAccent;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: border,
      dismissDirection: DismissDirection.vertical,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.only(
          bottom: isTop ? MediaQuery.of(context).size.height - 90 : 36,
          left: 16,
          right: 16),
    ));
  }

  errorFetch(DioExceptionType type) {
    String message = '';
    switch (type) {
      case DioException.connectionTimeout:
      case DioException.connectionError:
        message = 'اینترنت خود را چک کنید!!';
        break;
      default:
        message = "خطایی پیش آمده است لطفا لحضاتی دیگر تلاش کنید!!";
        break;
    }

    show(message, DialogStatus.error, true);
  }
}
