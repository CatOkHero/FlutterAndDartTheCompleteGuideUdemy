import 'package:cooking_app/screens/category_meals_screen.dart';
import 'package:cooking_app/screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.blue,
              ),
              bodyText2: TextStyle(
                color: Colors.blue,
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => CategoriesScreen(),
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => CategoriesScreen(),
      ),
    );
  }
}
