import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';
import 'package:shopping_list/data/categories.dart';

class GrocessaryList extends StatefulWidget {
  const GrocessaryList({super.key});

  @override
  State<GrocessaryList> createState() => _GrocessaryListState();
}

class _GrocessaryListState extends State<GrocessaryList> {
  List<GroceryItem> groceryItems = [];

  @override
  void initState() {
    // TODO: implement initState
    loadItems();
    super.initState();
  }

  void loadItems() async {
    var response = await http.get(
      Uri.https(
          'grocessarylist-default-rtdb.firebaseio.com', 'shoppingList.json'),
    );
    groceryItems.clear();
    final listData = json.decode(response.body);
    for (final item in listData.entries) {
      final groceryItem = GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: categories.values.firstWhere(
          (element) => element.title == item.value['category'],
        ),
      );

      setState(() {
        groceryItems.add(groceryItem);
      });
    }
  }

  void _addItem() async {
    var newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        groceryItems.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addItem,
            )
          ],
        ),
        body: groceryItems.length <= 0
            ? const Center(
                child: Text('No list item available'),
              )
            : ListView.builder(
                itemCount: groceryItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(groceryItems[index].id),
                    onDismissed: (direction) {
                      setState(() {
                        groceryItems.removeAt(index);
                      });
                    },
                    child: ListTile(
                      title: Text(groceryItems[index].name),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: groceryItems[index].category.color,
                      ),
                      trailing: Text('${groceryItems[index].quantity}'),
                    ),
                  );
                },
              ));
  }
}
