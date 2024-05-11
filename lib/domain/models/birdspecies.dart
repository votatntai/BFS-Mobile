class BirdSpecies {
  Pagination? pagination;
  List<BirdSpeciesData>? data;

  BirdSpecies({this.pagination, this.data});

  BirdSpecies.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <BirdSpeciesData>[];
      json['data'].forEach((v) {
        data!.add(BirdSpeciesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class BirdSpeciesData {
  String? id;
  String? thumbnailUrl;
  String? name;
  String? createAt;

  BirdSpeciesData({this.id, this.thumbnailUrl, this.name, this.createAt});

  BirdSpeciesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    name = json['name'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumbnailUrl'] = thumbnailUrl;
    data['name'] = name;
    data['createAt'] = createAt;
    return data;
  }
}
