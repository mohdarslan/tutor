import 'dart:convert';

import 'package:app/models/menu.dart';
import 'package:flutter/services.dart' show rootBundle;

class MenuViewModel {
  MenuViewModel._privateConstructor();

  static final MenuViewModel instance = MenuViewModel._privateConstructor();

  List<Item> oldOrders = [];

  List<Category> categories = [];

  List<Item> cart = [];
  List<Item> cartWithoutDuplicates = [];

  int total = 0;

  Future getMenuData() async {
    try {
      String data = await rootBundle.loadString('assets/menu.json');
      Map<String, dynamic> json = jsonDecode(data);

      for (String key in json.keys) {
        List<Item> items = [];
        for (Map<String, dynamic> e in json[key]) {
          Item item = Item.fromJson(e);
          items.add(item);
        }
        categories.add(Category(items: items, category: key));
      }

      print(categories);
    } catch (e) {
      print(e.toString());
    }
  }
}
