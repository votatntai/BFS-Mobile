class Checklists {
  Pagination? pagination;
  List<Checklist>? checklists;

  Checklists({this.pagination, this.checklists});

  Checklists.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      checklists = <Checklist>[];
      json['data'].forEach((v) {
        checklists!.add(new Checklist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.checklists != null) {
      data['data'] = this.checklists!.map((v) => v.toJson()).toList();
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

class Checklist {
  String? id;
  String? title;
  Assignee? assignee;
  bool? status;
  int? order;
  String? createAt;

  Checklist(
      {this.id,
      this.title,
      this.assignee,
      this.status,
      this.order,
      this.createAt});

  Checklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    assignee =
        json['asignee'] != null ? new Assignee.fromJson(json['asignee']) : null;
    status = json['status'];
    order = json['order'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.assignee != null) {
      data['asignee'] = this.assignee!.toJson();
    }
    data['status'] = this.status;
    data['order'] = this.order;
    data['createAt'] = this.createAt;
    return data;
  }
}

class Assignee {
  String? id;
  String? name;
  String? avatarUrl;
  String? email;
  String? phone;
  Null? janglee;

  Assignee(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.phone,
      this.janglee});

  Assignee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    phone = json['phone'];
    janglee = json['janglee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['janglee'] = this.janglee;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Assignee &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
