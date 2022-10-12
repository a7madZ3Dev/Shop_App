import '../category_model/category_model.dart';

class HomeModel {
  final bool status;
  final String? message;
  final HomeDataModel? data; 
  HomeModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> jsonData) {
    return HomeModel(
      status: jsonData['status'],
      message: jsonData['message'] != null ? jsonData['message'] : null,
      data: jsonData['data'] != null
          ? HomeDataModel.fromJson(jsonData['data'])
          : null,
    );
  }
}

class HomeDataModel {
  final List<Banner> banners;
  final List<Product> products;

  HomeDataModel({
    required this.banners,
    required this.products,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> jsonData) {
    return HomeDataModel(
      banners: jsonData['banners'] != null
          ? jsonData['banners']
              .map<Banner>((element) => Banner.fromJson(element))
              .toList()
          : [],
      products: jsonData['products'] != null
          ? jsonData['products']
              .map<Product>((element) => Product.fromJson(element))
              .toList()
          : [],
    );
  }
}

class Banner {
  final int id;
  final String image;
  final Product? product;
  final Category? category;
  Banner({
   required this.id,
   required this.image,
   this.product,
   this.category,
  });

  factory Banner.fromJson(Map<String, dynamic> jsonData) {
    return Banner(
      id: jsonData['id'],
      image: jsonData['image'],
      category: jsonData['category'] != null
          ? Category.fromJson(jsonData['category'])
          : null,
      product: jsonData['product'] != null
          ? Product.fromJson(jsonData['product'])
          : null,
    );
  }
}

class Product {
  final int id;
  final num price;
  final num? oldPrice;
  final num? discount;
  final String? description;
  final String image;
  final String name;
  final List<dynamic>? images;
  final bool? inFavorites;
  final bool? inCart;
  Product({
    required this.id,
    required this.price,
    this.oldPrice,
    this.discount,
    this.description,
    required this.image,
    required this.name,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
      id: jsonData['id'],
      price: jsonData['price'],
      oldPrice: jsonData['old_price'],
      discount: jsonData['discount'],
      image: jsonData['image'],
      name: jsonData['name'],
      description: jsonData['description'],
      images: jsonData['images'] != null ? jsonData['images'] : [],
      inFavorites: jsonData['in_favorites'],
      inCart: jsonData['in_cart'],
    );
  }
}
