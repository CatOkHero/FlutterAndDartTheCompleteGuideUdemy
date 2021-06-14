import 'package:flutter/material.dart';

enum MealComplexity {
  Simple,
  Challenging,
  Hard,
}

enum MealAffordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final String title;
  final List<String> categories;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  final MealComplexity complexity;
  final MealAffordability affordability;

  const Meal({
    @required this.id,
    @required this.title,
    @required this.categories,
    @required this.ingredients,
    this.imageUrl,
    this.steps,
    this.duration,
    this.isGlutenFree,
    this.isLactoseFree,
    this.isVegan,
    this.isVegetarian,
    this.complexity,
    this.affordability,
  });
}
