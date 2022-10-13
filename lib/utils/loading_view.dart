import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key, this.size = 40}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitWanderingCubes(
      color: const Color.fromRGBO(59, 6, 122, 1),
      size: size,
    ));
  }
}

showLoadingDialog({
  required BuildContext context,
}) {
  showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Center(child: LoadingView());
      });
}

hideLoadingDialog({required BuildContext context}) {
  Navigator.pop(context);
}
