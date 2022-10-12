class CategoryModel {
  final bool status;
  final String? message;
  final CategoriesDataModel data;
  CategoryModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      status: jsonData['status'],
      message: jsonData['message'] != null ? jsonData['message'] : null,
      data: CategoriesDataModel.fromJson(
        jsonData['data'],
      ),
    );
  }
}

class CategoriesDataModel {
  final int? currentPage;
  final List<Category> data;
  CategoriesDataModel({
    this.currentPage,
    required this.data,
  });

  factory CategoriesDataModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoriesDataModel(
        currentPage: jsonData['current_page'],
        data: jsonData['data'] != null
            ? jsonData['data']
                .map<Category>((element) => Category.fromJson(element))
                .toList()
            : []);
  }
}

class Category {
  final int id;
  final String image;
  final String name;
  Category({
    required this.id,
    required this.image,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
    );
  }
}
