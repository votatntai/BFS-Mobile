class BirdCategories {
  Pagination? pagination;
  List<BirdCategory>? birdcategories;

  BirdCategories({this.pagination, this.birdcategories});

  BirdCategories.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      birdcategories = <BirdCategory>[];
      json['data'].forEach((v) {
        birdcategories!.add(new BirdCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.birdcategories != null) {
      data['data'] = this.birdcategories!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalRow'] = this.totalRow;
    return data;
  }
}

class BirdCategory {
  String? id;
  String? thumbnailUrl;
  String? name;

BirdCategory({this.id, this.thumbnailUrl, this.name});

BirdCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['name'] = this.name;
    return data;
  }
}
