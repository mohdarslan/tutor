// ignore_for_file: prefer_const_constructors

import 'package:app/view_models/menu_viewmodel.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  MenuViewModel menu = MenuViewModel.instance;
  List<bool> _isOpen = [];
  bool oldOrdersIsOpen = false;

  @override
  void initState() {
    menu.getMenuData().then((value) {
      setState(() {});
      _isOpen = List.generate(menu.categories.length, (index) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: menu.categories.isEmpty
            ? CircularProgressIndicator()
            : SafeArea(
                child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        // for (int i = 0; i < menu.oldOrders.length; i++)
                        if (menu.oldOrders.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Pervious Orders'),
                                    Spacer(),
                                    Text(menu.oldOrders.length.toString()),
                                    InkWell(
                                        onTap: () {
                                          oldOrdersIsOpen = !oldOrdersIsOpen;
                                          setState(() {});
                                        },
                                        child: Icon(oldOrdersIsOpen
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right))
                                  ],
                                ),
                                Divider(),
                                AnimatedCrossFade(
                                    firstChild: Column(
                                      children: [
                                        for (int j = 0;
                                            j < menu.oldOrders.length;
                                            j++)
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(menu
                                                          .oldOrders[j].name),
                                                      SizedBox(height: 8),
                                                      Text(
                                                          '\$ ${menu.oldOrders[j].price}')
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  menu.cart.contains(
                                                          menu.oldOrders[j])
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          64)),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 8),
                                                              InkWell(
                                                                  onTap: () {
                                                                    menu.cart.remove(
                                                                        menu.oldOrders[
                                                                            j]);
                                                                    menu.total -= menu
                                                                        .oldOrders[
                                                                            j]
                                                                        .price;

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .orange,
                                                                  )),
                                                              SizedBox(
                                                                  width: 8),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Text(menu
                                                                    .cart
                                                                    .where((e) =>
                                                                        e ==
                                                                        menu.oldOrders[
                                                                            j])
                                                                    .length
                                                                    .toString()),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    menu.cart.add(
                                                                        menu.oldOrders[
                                                                            j]);
                                                                    menu.total += menu
                                                                        .oldOrders[
                                                                            j]
                                                                        .price;

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .orange)),
                                                              SizedBox(
                                                                  width: 8),
                                                            ],
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            menu.cart.add(menu
                                                                .oldOrders[j]);
                                                            menu.total += menu
                                                                .oldOrders[j]
                                                                .price;

                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        8),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .orange),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            64)),
                                                            child: Text('Add'),
                                                          ),
                                                        )
                                                ],
                                              ))
                                      ],
                                    ),
                                    secondChild: SizedBox(),
                                    crossFadeState: oldOrdersIsOpen
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration: Duration(milliseconds: 300))
                              ],
                            ),
                          ),
                        for (int i = 0; i < menu.categories.length; i++)
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(menu.categories[i].category),
                                    Spacer(),
                                    Text(menu.categories[i].items.length
                                        .toString()),
                                    InkWell(
                                        onTap: () {
                                          _isOpen[i] = !_isOpen[i];
                                          setState(() {});
                                        },
                                        child: Icon(_isOpen[i]
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right))
                                  ],
                                ),
                                Divider(),
                                AnimatedCrossFade(
                                    firstChild: Column(
                                      children: [
                                        for (int j = 0;
                                            j < menu.categories[i].items.length;
                                            j++)
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(menu
                                                              .categories[i]
                                                              .items[j]
                                                              .name),
                                                          SizedBox(width: 16),
                                                          if (menu.oldOrders
                                                              .contains(menu
                                                                  .categories[i]
                                                                  .items[j]))
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .pink,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              64)),
                                                              child: Text(
                                                                'Best Seller',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                          '\$ ${menu.categories[i].items[j].price}')
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  menu.cart.contains(menu
                                                          .categories[i]
                                                          .items[j])
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .orange),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          64)),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 8),
                                                              InkWell(
                                                                  onTap: () {
                                                                    menu.cart.remove(menu
                                                                        .categories[
                                                                            i]
                                                                        .items[j]);
                                                                    menu.total -= menu
                                                                        .categories[
                                                                            i]
                                                                        .items[
                                                                            j]
                                                                        .price;

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .orange,
                                                                  )),
                                                              SizedBox(
                                                                  width: 8),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Text(menu
                                                                    .cart
                                                                    .where((e) =>
                                                                        e ==
                                                                        menu.categories[i]
                                                                            .items[j])
                                                                    .length
                                                                    .toString()),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    menu.cart.add(menu
                                                                        .categories[
                                                                            i]
                                                                        .items[j]);
                                                                    menu.total += menu
                                                                        .categories[
                                                                            i]
                                                                        .items[
                                                                            j]
                                                                        .price;

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .orange)),
                                                              SizedBox(
                                                                  width: 8),
                                                            ],
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            menu.cart.add(menu
                                                                .categories[i]
                                                                .items[j]);
                                                            menu.total += menu
                                                                .categories[i]
                                                                .items[j]
                                                                .price;

                                                            if (!menu.oldOrders
                                                                .contains(menu
                                                                    .categories[
                                                                        i]
                                                                    .items[j]))
                                                              menu.cartWithoutDuplicates
                                                                  .add(menu
                                                                      .categories[
                                                                          i]
                                                                      .items[j]);

                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        8),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .orange),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            64)),
                                                            child: Text('Add'),
                                                          ),
                                                        )
                                                ],
                                              ))
                                      ],
                                    ),
                                    secondChild: SizedBox(),
                                    crossFadeState: _isOpen[i]
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration: Duration(milliseconds: 300))
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        menu
                          ..oldOrders.addAll([...menu.cartWithoutDuplicates])
                          ..cart = []
                          ..cartWithoutDuplicates = []
                          ..total = 0;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SizedBox(),
                            Spacer(),
                            Text(
                              'Place Order',
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              '\$ ${menu.total}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ))
                ],
              )));
  }
}
