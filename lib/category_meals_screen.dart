import 'package:flutter/material.dart';

import 'models/category.dart';

class CategoryMealScreen extends StatelessWidget {
  // final Category category;

  // CategoryMealScreen(this.category); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}
