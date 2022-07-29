import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/resource.dart';
import '../core/status.dart';

typedef ChildDataWidget<T> = Widget Function(BuildContext context, T data);


class NetworkBoundWidget<T> extends StatelessWidget {
  final Future<Resource<T?>> future;
  final ChildDataWidget<T> child;
  final Widget? loading;
  final Widget? failure;
  final Widget? error;
  final String? loadingMessage;

  const NetworkBoundWidget({
    super.key,
    required this.child,
    required this.future,
    this.loading,
    this.failure,
    this.error,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFuture();
  }

  FutureBuilder<Resource<dynamic>> _buildFuture() {
    return FutureBuilder<Resource<T?>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading(null, context);
          }
          if (snapshot.hasData) {
            final networkBoundData = snapshot.data!.data;
            switch (snapshot.data!.status) {
              case Status.loading:
                return _buildLoading(networkBoundData, context);
              case Status.success:
                return child(context, networkBoundData!);
              case Status.failure:
              case Status.exception:
                final errorMessage = snapshot.data!.getErrorOr();
                return Center(child: Text(errorMessage));

              case Status.empty:
                return const SizedBox.shrink();
            }
          } else {
            return error ?? Center(child: Text(snapshot.error.toString()));
          }
        });
  }

  Widget _buildLoading(networkBoundData, BuildContext context) {
    if (networkBoundData == null || (networkBoundData is List && networkBoundData.isEmpty)) {
      return loading ?? const Center(child: CircularProgressIndicator());
    } else {
      return child(context, networkBoundData);
    }
  }
}
