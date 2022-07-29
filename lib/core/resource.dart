import 'package:conoce_bonao/core/status.dart';

typedef ErrorParser<R extends Exception> = String? Function(R exception);

class Resource<T> {
  T? data;
  Exception? exception;
  String? errorMessage;
  Status status;
  Resource([this.data]) : status = Status.loading;
  Resource.success([this.data]) : status = Status.success;
  Resource.error([this.exception, this.errorMessage]) : status = Status.failure;
  Resource.loading() : status = Status.loading;
  Resource.empty() : status = Status.empty;

  static Future<Resource<T>> fromCallback<T, R extends Exception>(
    Future<T> Function() callback, {
    ErrorParser<R>? errorParser,
  }) async {
    try {
      final result = await callback();
      return result is Resource ? result as Resource<T> : Resource<T>.success(result);
    } on Exception catch (exception) {
      return Resource<T>.error(exception, errorParser?.call(exception as R));
    } on String catch (error) {
      return Resource<T>.error(null, error);
    }
  }

  bool get isSuccessful => status == Status.success;
  bool get isError => status == Status.failure;
  bool get isLoading => status == Status.loading;
  bool get isEmpty => status == Status.empty;

  String getErrorOr([String error = "Ha ocurrido un error inesperado"]) {
    return errorMessage ?? error;
  }

  bool isExceptionOfType<R extends Exception>() => exception is R;
}
