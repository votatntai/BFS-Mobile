import 'dart:ffi';

class Foods {
  Pagination? pagination;
  List<Food>? foods;

  Foods({this.pagination, this.foods});

  Foods.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      foods = <Food>[];
      json['data'].forEach((v) {
        foods!.add(Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (foods != null) {
      data['data'] = foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? pageNumber;
  int? pageSize;
  int? totalRow;

  Pagination({this.pageNumber, this.pageSize, this.totalRow});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalRow = json['totalRow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['totalRow'] = totalRow;
    return data;
  }
}

class Food {
  String? id;
  String? thumbnailUrl;
  String? name;
  FoodCategory? foodCategory;
  double? quantity;
  FoodCategory? unitOfMeasurement;
  String? status;
  String? createAt;

  Food(
      {this.id,
      this.thumbnailUrl,
      this.name,
      this.foodCategory,
      this.quantity,
      this.unitOfMeasurement,
      this.status,
      this.createAt});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    name = json['name'];
    foodCategory = json['foodCategory'] != null
        ? FoodCategory.fromJson(json['foodCategory'])
        : null;
    quantity = json['quantity'];
    unitOfMeasurement = json['unitOfMeasurement'] != null
        ? FoodCategory.fromJson(json['unitOfMeasurement'])
        : null;
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumbnailUrl'] = thumbnailUrl;
    data['name'] = name;
    if (foodCategory != null) {
      data['foodCategory'] = foodCategory!.toJson();
    }
    data['quantity'] = quantity;
    if (unitOfMeasurement != null) {
      data['unitOfMeasurement'] = unitOfMeasurement!.toJson();
    }
    data['status'] = status;
    data['createAt'] = createAt;
    return data;
  }
}

class FoodCategory {
  String? id;
  String? name;
  String? createAt;

  FoodCategory({this.id, this.name, this.createAt});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createAt'] = createAt;
    return data;
  }
}
