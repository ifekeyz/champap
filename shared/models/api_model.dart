class ApiResponse<T> {
  ApiResponse({
    this.success = false,
    this.message,
    this.data,
    this.token
  });

  bool success;
  String? message;
  T? data;
  String? token;
}
