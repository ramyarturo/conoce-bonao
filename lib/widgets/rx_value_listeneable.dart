import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/core/resource.dart';

class RxValueListeneableBuilder<T> extends StatelessWidget {
  final RxObjectMixin<Resource<T>> value;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? onError;
  final Widget? onLoading;

  const RxValueListeneableBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (value.value.isSuccessful) {
        return builder(context, value.value.data as T);
      } else if (value.value.isError) {
        return onError ?? Center(child: Text(value.value.getErrorOr()));
      }
      return onLoading ?? const SizedBox.shrink();
    });
  }
}
