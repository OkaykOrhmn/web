import 'package:web/data/model/product_model.dart';

class CartListModel {
  int? status;
  List<Carts>? carts;

  CartListModel({this.status, this.carts});

  CartListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carts {
  int? id;
  String? name;
  int? userId;
  int? status;
  List<Products>? products;

  Carts({this.id, this.name, this.userId, this.status, this.products});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['userId'];
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productId;
  int? cartId;
  int? count;
  Product? product;

  Products({this.productId, this.cartId, this.count, this.product});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    cartId = json['cartId'];
    count = json['count'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['cartId'] = this.cartId;
    data['count'] = this.count;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Likes {
  int? userId;
  int? productId;

  Likes({this.userId, this.productId});

  Likes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    return data;
  }
}
