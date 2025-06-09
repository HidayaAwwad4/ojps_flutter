class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;

  static ApiException authTokenNotFound() =>
      ApiException('Please log in to continue.');

  static ApiException jobCreationFailed() =>
      ApiException('Failed to create the job. Please check your inputs.');

  static ApiException jobUpdateFailed() =>
      ApiException('Failed to update the job. Please try again.');

  static ApiException jobDeletionFailed() =>
      ApiException('Failed to delete the job.');

  static ApiException jobNotFound() =>
      ApiException('This job is no longer available.');

  static ApiException defaultError(String? msg) =>
      ApiException(msg ?? 'An unexpected error occurred. Please try again.');
}