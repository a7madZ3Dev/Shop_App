class ChangeFavoriteModel {
  final bool status;
  final String message;

  ChangeFavoriteModel({
    this.status,
    this.message,
  });

  factory ChangeFavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    return ChangeFavoriteModel(
      status: jsonData['status'],
      message: jsonData['message'],
    );
  }
}
