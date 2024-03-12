class Cages {
  Pagination? pagination;
  List<Cage>? cages;

  Cages({this.pagination, this.cages});

  Cages.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      cages = <Cage>[];
      json['data'].forEach((v) {
        cages!.add(new Cage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.cages != null) {
      data['data'] = this.cages!.map((v) => v.toJson()).toList();
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

class Cage {
  String? id;
  String? code;
  String? name;
  String? material;
  String? description;
  double? height;
  double? width;
  double? depth;
  String? thumbnailUrl;
  CareMode? careMode;
  Species? species;
  Species? area;
  String? createAt;

  Cage(
      {this.id,
      this.code,
      this.name,
      this.material,
      this.description,
      this.height,
      this.width,
      this.depth,
      this.thumbnailUrl,
      this.careMode,
      this.species,
      this.area,
      this.createAt});

  Cage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    material = json['material'];
    description = json['description'];
    height = json['height'];
    width = json['width'];
    depth = json['depth'];
    thumbnailUrl = json['thumbnailUrl'];
    careMode = json['careMode'] != null
        ? new CareMode.fromJson(json['careMode'])
        : null;
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    area = json['area'] != null ? new Species.fromJson(json['area']) : null;
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['material'] = this.material;
    data['description'] = this.description;
    data['height'] = this.height;
    data['width'] = this.width;
    data['depth'] = this.depth;
    data['thumbnailUrl'] = this.thumbnailUrl;
    if (this.careMode != null) {
      data['careMode'] = this.careMode!.toJson();
    }
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    data['createAt'] = this.createAt;
    return data;
  }
}

class CareMode {
  String? id;
  int? priority;
  String? name;
  String? createAt;

  CareMode({this.id, this.priority, this.name, this.createAt});

  CareMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    name = json['name'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['name'] = this.name;
    data['createAt'] = this.createAt;
    return data;
  }
}

class Species {
  String? id;
  String? thumbnailUrl;
  String? name;
  String? createAt;

  Species({this.id, this.thumbnailUrl, this.name, this.createAt});

  Species.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    name = json['name'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['name'] = this.name;
    data['createAt'] = this.createAt;
    return data;
  }
}
