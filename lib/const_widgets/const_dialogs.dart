import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';

showLoader(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      return const WillPopScope(
        onWillPop: _onWillPop,
        child: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              // valueColor: AlwaysStoppedAnimation<Color>(AppColors.blackColor),
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> _onWillPop() async {
  return false;
}

showSnackBar(text) {
  return ScaffoldMessenger.of(ContextHolder.currentContext)
      .showSnackBar(SnackBar(content: Text(text ?? "")));
}
