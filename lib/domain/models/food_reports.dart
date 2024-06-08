import 'foods.dart';
import 'staff.dart';

class FoodReports {
  Pagination? pagination;
  List<FoodReport>? foodReports;

  FoodReports({this.pagination, this.foodReports});

  FoodReports.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      foodReports = <FoodReport>[];
      json['data'].forEach((v) {
        foodReports!.add(FoodReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (foodReports != null) {
      data['data'] = foodReports!.map((v) => v.toJson()).toList();
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

class FoodReport {
  String? id;
  Staff? staff;
  Food? food;
  double? lastQuantity;
  double? remainQuantity;
  String? description;
  String? createDate;
  bool? isReported;

  FoodReport(
      {this.id,
      this.staff,
      this.food,
      this.lastQuantity,
      this.remainQuantity,
      this.description,
      this.createDate,
      this.isReported});

  FoodReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
    food = json['food'] != null ? Food.fromJson(json['food']) : null;
    lastQuantity = json['lastQuantity'];
    remainQuantity = json['remainQuantity'];
    description = json['description'];
    createDate = json['createDate'];
    isReported = json['isReported'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    if (food != null) {
      data['food'] = food!.toJson();
    }
    data['lastQuantity'] = lastQuantity;
    data['remainQuantity'] = remainQuantity;
    data['description'] = description;
    data['createDate'] = createDate;
    data['isReported'] = isReported;
    return data;
  }
}
