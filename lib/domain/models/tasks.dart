import 'cages.dart';

class Tasks {
  Pagination? pagination;
  List<Task>? tasks;

  Tasks({this.pagination, this.tasks});

  Tasks.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      tasks = <Task>[];
      json['data'].forEach((v) {
        tasks!.add(new Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.tasks != null) {
      data['data'] = this.tasks!.map((v) => v.toJson()).toList();
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

class Task {
  String? id;
  Cage? cage;
  String? title;
  String? description;
  Manager? manager;
  String? deadLine;
  String? createAt;
  List<CheckLists>? checkLists;
  String? status;

  Task(
      {this.id,
      this.cage,
      this.title,
      this.description,
      this.manager,
      this.deadLine,
      this.createAt,
      this.checkLists,
      this.status});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cage = json['cage'] != null ? new Cage.fromJson(json['cage']) : null;
    title = json['title'];
    description = json['description'];
    manager =
        json['manager'] != null ? new Manager.fromJson(json['manager']) : null;
    deadLine = json['deadLine'];
    createAt = json['createAt'];
    if (json['checkLists'] != null) {
      checkLists = <CheckLists>[];
      json['checkLists'].forEach((v) {
        checkLists!.add(new CheckLists.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cage != null) {
      data['cage'] = this.cage!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.manager != null) {
      data['manager'] = this.manager!.toJson();
    }
    data['deadLine'] = this.deadLine;
    data['createAt'] = this.createAt;
     if (this.checkLists != null) {
      data['checkLists'] = this.checkLists!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Manager {
  String? id;
  String? name;
  String? avatarUrl;
  String? email;
  String? phone;
  String? status;

  Manager(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.phone,
      this.status});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    return data;
  }
}

class CheckLists {
  String? id;
  String? title;
  Assignee? assignee;
  bool? status;
  int? order;
  String? createAt;

  CheckLists(
      {this.id,
      this.title,
      this.assignee,
      this.status,
      this.order,
      this.createAt});

  CheckLists.fromJson(Map<String, dynamic> json) {
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
