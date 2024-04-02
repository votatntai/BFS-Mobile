import 'cages.dart';

class Tickets {
  Pagination? pagination;
  List<Ticket>? tickets;

  Tickets({this.pagination, this.tickets});

  Tickets.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      tickets = <Ticket>[];
      json['data'].forEach((v) {
        tickets!.add(new Ticket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.tickets != null) {
      data['data'] = this.tickets!.map((v) => v.toJson()).toList();
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

class Ticket {
  String? id;
  String? ticketCategory;
  Creator? creator;
  String? priority;
  Creator? assignee;
  Cage? cage;
  String? description;
  String? image;
  String? status;
  String? createAt;

  Ticket(
      {this.id,
      this.ticketCategory,
      this.creator,
      this.priority,
      this.assignee,
      this.cage,
      this.description,
      this.image,
      this.status,
      this.createAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketCategory = json['ticketCategory'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    priority = json['priority'];
    assignee = json['assignee'] != null
        ? new Creator.fromJson(json['assignee'])
        : null;
    cage = json['cage'] != null ? new Cage.fromJson(json['cage']) : null;
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticketCategory'] = this.ticketCategory;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['priority'] = this.priority;
    if (this.assignee != null) {
      data['assignee'] = this.assignee!.toJson();
    }
    if (this.cage != null) {
      data['cage'] = this.cage!.toJson();
    }
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    return data;
  }
}

class Creator {
  String? id;
  String? name;
  String? avatarUrl;
  String? email;
  String? phone;
  Null? janglee;

  Creator(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.phone,
      this.janglee});

  Creator.fromJson(Map<String, dynamic> json) {
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
}

