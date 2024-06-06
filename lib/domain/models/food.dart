import 'dart:ffi';

import 'foods.dart';

class Foodd {
  Food? food;
  double? planQuantity;

  Foodd({this.food, this.planQuantity});

  Foodd.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? Food.fromJson(json['food']) : null;
    planQuantity = json['planQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (food != null) {
      data['food'] = food!.toJson();
    }
    data['planQuantity'] = planQuantity;
    return data;
  }
}