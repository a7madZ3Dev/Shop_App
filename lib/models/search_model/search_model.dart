import '../../models/home_model/home_model.dart';

class SearchModel {
  final bool status;
  final String? message;
  final SearchDataModel? data;
  SearchModel({
    required this.status,
    this.message,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> jsonData) {
    return SearchModel(
      status: jsonData['status'],
      message: jsonData['message'] != null ? jsonData['message'] : null,
      data: jsonData['data'] != null
          ? SearchDataModel.fromJson(
              jsonData['data'],
            )
          : null,
    );
  }
}

class SearchDataModel {
  final int? currentPage;
  final List<Product> data;
  SearchDataModel({
    this.currentPage,
    required this.data,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> jsonData) {
    return SearchDataModel(
      currentPage: jsonData['current_page'],
      data: jsonData['data'] != null
          ? jsonData['data']
              .map<Product>((element) => Product.fromJson(element))
              .toList()
          : [],
    );
  }
}
