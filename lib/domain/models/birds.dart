class Birds {
  Pagination? pagination;
  List<Bird>? birds;

  Birds({this.pagination, this.birds});

  Birds.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      birds = <Bird>[];
      json['data'].forEach((v) {
        birds!.add(Bird.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (birds != null) {
      data['data'] = birds!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['totalRow'] = totalRow;
    return data;
  }
}

class Bird {
  String? id;
  String? thumbnailUrl;
  String? characteristic;
  String? name;
  bool? gender;
  String? dayOfBirth;
  String? code;
  Species? species;
  CareMode? careMode;
  String? createAt;

  Bird(
      {this.id,
      this.thumbnailUrl,
      this.characteristic,
      this.name,
      this.gender,
      this.dayOfBirth,
      this.code,
      this.species,
      this.careMode,
      this.createAt});

  Bird.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    characteristic = json['characteristic'];
    name = json['name'];
    gender = json['gender'];
    dayOfBirth = json['dayOfBirth'];
    code = json['code'];
    species =
        json['species'] != null ? Species.fromJson(json['species']) : null;
    careMode = json['careMode'] != null
        ? CareMode.fromJson(json['careMode'])
        : null;
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['thumbnailUrl'] = thumbnailUrl;
    data['characteristic'] = characteristic;
    data['name'] = name;
    data['gender'] = gender;
    data['dayOfBirth'] = dayOfBirth;
    data['code'] = code;
    if (species != null) {
      data['species'] = species!.toJson();
    }
    if (careMode != null) {
      data['careMode'] = careMode!.toJson();
    }
    data['createAt'] = createAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['thumbnailUrl'] = thumbnailUrl;
    data['name'] = name;
    data['createAt'] = createAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['priority'] = priority;
    data['name'] = name;
    data['createAt'] = createAt;
    return data;
  }
}
