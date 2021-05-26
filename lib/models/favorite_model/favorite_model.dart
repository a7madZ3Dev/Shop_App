import '../../models/home_model/home_model.dart';

class FavoriteModel {
  final bool status;
  final dynamic message;
  final FavoritesDataModel data;
  FavoriteModel({
    this.status,
    this.message,
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    return FavoriteModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: jsonData['data'] != null
          ? FavoritesDataModel.fromJson(
              jsonData['data'],
            )
          : null,
    );
  }
}

class FavoritesDataModel {
  final int currentPage;
  final List<FavoriteData> data;
  FavoritesDataModel({
    this.currentPage,
    this.data,
  });

  factory FavoritesDataModel.fromJson(Map<String, dynamic> jsonData) {
    return FavoritesDataModel(
      currentPage: jsonData['current_page'],
      data: jsonData['data'] != null
          ? jsonData['data']
              .map<FavoriteData>((element) => FavoriteData.fromJson(element))
              .toList()
          : [],
    );
  }
}

class FavoriteData {
  final int id;
  final Product data;
  FavoriteData({
    this.id,
    this.data,
  });
  factory FavoriteData.fromJson(Map<String, dynamic> jsonData) {
    return FavoriteData(
      id: jsonData['id'],
      data: Product.fromJson(jsonData['product']),
    );
  }
}
