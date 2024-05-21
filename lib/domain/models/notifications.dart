class Notifications {
  Pagination? pagination;
  List<NotificationItem>? notifications;

  Notifications({this.pagination, this.notifications});

  Notifications.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      notifications = <NotificationItem>[];
      json['data'].forEach((v) {
        notifications!.add(new NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.notifications != null) {
      data['data'] = this.notifications!.map((v) => v.toJson()).toList();
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

class NotificationItem {
  String? id;
  String? title;
  String? message;
  String? link;
  String? type;
  bool? isRead;
  String? createAt;

  NotificationItem(
      {this.id,
      this.title,
      this.message,
      this.link,
      this.type,
      this.isRead,
      this.createAt});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    link = json['link'];
    type = json['type'];
    isRead = json['isRead'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['link'] = this.link;
    data['type'] = this.type;
    data['isRead'] = this.isRead;
    data['createAt'] = this.createAt;
    return data;
  }
}
