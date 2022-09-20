class Item {
  final String name;
  final int price;
  final bool inStock;

  Item({required this.name, required this.price, required this.inStock});

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(name: json['name'], price: json['price'], inStock: json['instock']);
}

class Category {
  final List<Item> items;
  final String category;
  Category({required this.items, required this.category});
}
