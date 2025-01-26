import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';

class GrocessaryList extends StatefulWidget {
  const GrocessaryList({super.key});

  @override
  State<GrocessaryList> createState() => _GrocessaryListState();
}

class _GrocessaryListState extends State<GrocessaryList> {
  List<GroceryItem> groceryItems = [];
  void _addItem() async {
    var newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return null;
    }
    setState(() {
      groceryItems.add(newItem);
    });
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
