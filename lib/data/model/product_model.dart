class ProductModel {
  int? status;
  Product? product;

  ProductModel({this.status, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  double? price;
  bool? isAvailable;
  List<dynamic>? likes;
  String? mainImageUrl;
  List<dynamic>? banners;
  double? rate;
  int? categoryId;
  String? description;
  String? createdAt;
  Category? category;
  List<Highlights>? highlights;
  int? count;

  Product(
      {this.id,
      this.name,
      this.price,
      this.isAvailable,
      this.mainImageUrl,
      this.banners,
      this.rate,
      this.categoryId,
      this.description,
      this.createdAt,
      this.category,
      this.highlights,
      this.count});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'] != null
        ? double.tryParse(json['price'].toString())
        : null;
    isAvailable = json['isAvailable'];
    mainImageUrl = json['mainImageUrl'];
    banners = json['banners'] != null ? json['banners'].cast<String?>() : [];
    likes = json['likes'] != null ? json['likes'].cast<String?>() : [];
    rate =
        json['rate'] != null ? double.tryParse(json['rate'].toString()) : null;
    categoryId = json['categoryId'];
    description = json['description'];
    createdAt = json['createdAt'];
    count = json['count'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['highlights'] != null) {
      highlights = <Highlights>[];
      json['highlights'].forEach((v) {
        highlights!.add(Highlights.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['isAvailable'] = isAvailable;
    data['mainImageUrl'] = mainImageUrl;
    data['banners'] = banners;
    data['likes'] = likes;
    data['rate'] = rate;
    data['categoryId'] = categoryId;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['count'] = count;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (highlights != null) {
      data['highlights'] = highlights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? imageUrl;

  Category({this.id, this.name, this.imageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Highlights {
  int? id;
  String? name;
  String? desc;
  int? productId;

  Highlights({this.id, this.name, this.desc, this.productId});

  Highlights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['productId'] = productId;
    return data;
  }
}
