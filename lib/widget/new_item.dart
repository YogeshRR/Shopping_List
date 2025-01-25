import 'package:flutter/material.dart';

import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    // TODO: implement createState
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length < 3 ||
                      value.length > 50) {
                    return 'Please enter a name';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 3,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Please enter a quantity';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(items: [
                      for (final cateogry in categories.entries)
                        DropdownMenuItem(
                          value: cateogry.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: cateogry.value.color,
                              ),
                              const SizedBox(width: 8),
                              Text(cateogry.value.title),
                            ],
                          ),
                        ),
                    ], onChanged: (value) {}),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add Button'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
