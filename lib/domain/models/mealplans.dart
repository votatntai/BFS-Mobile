import 'cages.dart';

class MealPlans {
  Pagination? pagination;
  List<MealPlan>? mealPlans;

  MealPlans({this.pagination, this.mealPlans});

  MealPlans.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      mealPlans = <MealPlan>[];
      json['data'].forEach((v) {
        mealPlans!.add(MealPlan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (mealPlans != null) {
      data['data'] = mealPlans!.map((v) => v.toJson()).toList();
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

class MealPlan {
  String? id;
  String? title;
  String? from;
  String? to;
  Menu? menu;
  Cage? cage;
  String? createAt;

  MealPlan(
      {this.id,
      this.title,
      this.from,
      this.to,
      this.menu,
      this.cage,
      this.createAt});

  MealPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    from = json['from'];
    to = json['to'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    cage = json['cage'] != null ? Cage.fromJson(json['cage']) : null;
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['from'] = from;
    data['to'] = to;
    if (menu != null) {
      data['menu'] = menu!.toJson();
    }
    if (cage != null) {
      data['cage'] = cage!.toJson();
    }
    data['createAt'] = createAt;
    return data;
  }
}

class Menu {
  String? id;
  String? name;
  String? createAt;
  List<MenuMeals>? menuMeals;

  Menu({this.id, this.name, this.createAt, this.menuMeals});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createAt = json['createAt'];
    if (json['menuMeals'] != null) {
      menuMeals = <MenuMeals>[];
      json['menuMeals'].forEach((v) {
        menuMeals!.add(MenuMeals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createAt'] = createAt;
    if (menuMeals != null) {
      data['menuMeals'] = menuMeals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuMeals {
  String? id;
  String? name;
  String? from;
  String? to;
  List<MealItems>? mealItems;
  String? createAt;

  MenuMeals(
      {this.id, this.name, this.from, this.to, this.mealItems, this.createAt});

  MenuMeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    from = json['from'];
    to = json['to'];
    if (json['mealItems'] != null) {
      mealItems = <MealItems>[];
      json['mealItems'].forEach((v) {
        mealItems!.add(MealItems.fromJson(v));
      });
    }
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['from'] = from;
    data['to'] = to;
    if (mealItems != null) {
      data['mealItems'] = mealItems!.map((v) => v.toJson()).toList();
    }
    data['createAt'] = createAt;
    return data;
  }
}

class MealItems {
  String? id;
  Food? food;
  double? quantity;
  int? order;

  MealItems({this.id, this.food, this.quantity, this.order});

  MealItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    food = json['food'] != null ? Food.fromJson(json['food']) : null;
    quantity = json['quantity'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (food != null) {
      data['food'] = food!.toJson();
    }
    data['quantity'] = quantity;
    data['order'] = order;
    return data;
  }
}

class Food {
  String? id;
  String? thumbnailUrl;
  String? name;
  FoodCategory? foodCategory;
  double? quantity;
  FoodCategory? unitOfMeasurement;
  String? status;
  String? createAt;

  Food(
      {this.id,
      this.thumbnailUrl,
      this.name,
      this.foodCategory,
      this.quantity,
      this.unitOfMeasurement,
      this.status,
      this.createAt});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnailUrl'];
    name = json['name'];
    foodCategory = json['foodCategory'] != null
        ? FoodCategory.fromJson(json['foodCategory'])
        : null;
    quantity = json['quantity'];
    unitOfMeasurement = json['unitOfMeasurement'] != null
        ? FoodCategory.fromJson(json['unitOfMeasurement'])
        : null;
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumbnailUrl'] = thumbnailUrl;
    data['name'] = name;
    if (foodCategory != null) {
      data['foodCategory'] = foodCategory!.toJson();
    }
    data['quantity'] = quantity;
    if (unitOfMeasurement != null) {
      data['unitOfMeasurement'] = unitOfMeasurement!.toJson();
    }
    data['status'] = status;
    data['createAt'] = createAt;
    return data;
  }
}

class FoodCategory {
  String? id;
  String? name;
  String? createAt;

  FoodCategory({this.id, this.name, this.createAt});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createAt'] = createAt;
    return data;
  }
}

