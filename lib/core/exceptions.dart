class LocationException implements Exception {
  String message;
  LocationException(this.message);
}

class RequestLocationServiceException extends LocationException {
  RequestLocationServiceException(super.message);
}

class DeniedLocationPermissionExcetion extends LocationException {
  DeniedLocationPermissionExcetion(super.message);
}