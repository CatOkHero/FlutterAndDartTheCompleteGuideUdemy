import 'package:cooking_app/controls/meal_item.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

import '../models/category.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  // final Category category;

  // CategoryMealScreen(this.category); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;
    final categoryMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, itemIndex) {
          return MealItemWidget(categoryMeals[itemIndex]);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
