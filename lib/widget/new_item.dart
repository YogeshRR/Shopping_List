import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

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
    final _formKey = GlobalKey<FormState>();
    var _selectedName = '';
    var _selectedQuantity = 1;
    var _selectedCategory = categories[Categories.vegetables];
    void _submitForm() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();
      http.post(
        Uri.https(
            'grocessarylist-default-rtdb.firebaseio.com', 'shoppingList.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _selectedName,
          'quantity': _selectedQuantity,
          'category': _selectedCategory?.title,
        }),
      );
      //Navigator.of(context).pop();
    }

    void resetForm() {
      _formKey.currentState!.reset();
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                onSaved: (value) {
                  _selectedName = value!;
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
                      onSaved: (newValue) =>
                          _selectedQuantity = int.parse(newValue!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: [
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
                        ],
                        onChanged: (value) {
                          _selectedCategory = value as Category;
                        }),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
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
