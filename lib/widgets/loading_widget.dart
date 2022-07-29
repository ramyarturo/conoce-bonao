import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SpinKitFadingCircle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

showLoading() {
  Get.dialog(
    const LoadingWidget(),
    barrierDismissible: false,
  );
}

hideLoading() {
  if(Get.isDialogOpen ?? false) {
    Get.back();
  }
}
