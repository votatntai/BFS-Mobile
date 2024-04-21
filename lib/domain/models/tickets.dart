import 'cages.dart';
import 'staff.dart';

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
  String? title;
  String? ticketCategory;
  Staff? creator;
  String? priority;
  Staff? assignee;
  Cage? cage;
  String? description;
  String? resultDescription;
  String? resultImage;
  String? image;
  String? status;
  String? createAt;

  Ticket(
      {this.id,
      this.title,
      this.ticketCategory,
      this.creator,
      this.priority,
      this.assignee,
      this.cage,
      this.description,
      this.resultDescription,
      this.resultImage,
      this.image,
      this.status,
      this.createAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    ticketCategory = json['ticketCategory'];
    creator =
        json['creator'] != null ? new Staff.fromJson(json['creator']) : null;
    priority = json['priority'];
    assignee = json['assignee'] != null
        ? new Staff.fromJson(json['assignee'])
        : null;
    cage = json['cage'] != null ? new Cage.fromJson(json['cage']) : null;
    description = json['description'];
    resultDescription = json['resultDescription'];
    resultImage = json['resultImage'];
    image = json['image'];
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
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
    data['resultDescription'] = this.resultDescription;
    data['resultImage'] = this.resultImage;
    data['image'] = this.image;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    return data;
  }
}

