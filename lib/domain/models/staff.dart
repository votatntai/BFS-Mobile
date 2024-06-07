class Staff {
  String? id;
  String? name;
  String? avatarUrl;
  String? email;
  String? phone;
  String? status;
  Farm? farm;

  Staff(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.phone,
      this.status,
      this.farm});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    farm = json['farm'] != null ? new Farm.fromJson(json['farm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    if (this.farm != null) {
      data['farm'] = this.farm!.toJson();
    }
    return data;
  }
}

class Farm {
  String? id;
  String? name;
  String? thumbnailUrl;
  String? address;
  String? phone;
  Manager? manager;
  List<Areas>? areas;
  String? createAt;

  Farm(
      {this.id,
      this.name,
      this.thumbnailUrl,
      this.address,
      this.phone,
      this.manager,
      this.areas,
      this.createAt});

  Farm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = json['thumbnailUrl'];
    address = json['address'];
    phone = json['phone'];
    manager =
        json['manager'] != null ? new Manager.fromJson(json['manager']) : null;
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['address'] = this.address;
    data['phone'] = this.phone;
    if (this.manager != null) {
      data['manager'] = this.manager!.toJson();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    data['createAt'] = this.createAt;
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
  Farm? farm;

  Manager(
      {this.id,
      this.name,
      this.avatarUrl,
      this.email,
      this.phone,
      this.status,
      this.farm});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    farm = json['farm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['farm'] = this.farm;
    return data;
  }
}

class Areas {
  String? id;
  String? name;
  String? thumbnailUrl;
  String? createAt;

  Areas({this.id, this.name, this.thumbnailUrl, this.createAt});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl = json['thumbnailUrl'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['createAt'] = this.createAt;
    return data;
  }
}
