import 'package:flutter/material.dart';

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
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 3,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (value) => null,
                ),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    return null;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
