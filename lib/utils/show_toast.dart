import 'package:flutter/material.dart';
//
// Future showToast({
//   required BuildContext context,
//   required String msg,
//   Color color = Colors.red,
// }) async {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: color,
//       content: Text(msg),
//       duration: const Duration(milliseconds: 1500),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//     ),
//   );
// }

void showToast({required BuildContext context, required String msg, bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(msg),
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}


