import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widget/new_item.dart';

class GrocessaryList extends StatelessWidget {
  const GrocessaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NewItem(),
                  ),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItems[index].category.color,
              ),
              trailing: Text('${groceryItems[index].quantity}'),
            );
          },
        ));
  }
}
