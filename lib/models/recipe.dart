import 'package:flutter/material.dart';

/// Model resep. [fromJson] / [toJson] dibuat agar bisa dipakai ulang
/// ketika data diambil dari API (response JSON).
class Recipe {
  final int id;
  final String name;
  final String category;
  final int timeMinutes;
  final String difficulty;
  final double rating;
  final String icon;
  final Color color;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.timeMinutes,
    required this.difficulty,
    required this.rating,
    required this.icon,
    required this.color,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        timeMinutes: json['time_minutes'] as int,
        difficulty: json['difficulty'] as String,
        rating: (json['rating'] as num).toDouble(),
        icon: json['icon'] as String,
        color: _hex(json['color'] as String),
        description: json['description'] as String,
        ingredients: List<String>.from(json['ingredients'] as List),
        steps: List<String>.from(json['steps'] as List),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'time_minutes': timeMinutes,
        'difficulty': difficulty,
        'rating': rating,
        'icon': icon,
        'description': description,
        'ingredients': ingredients,
        'steps': steps,
      };

  IconData get iconData => switch (icon) {
        'rice' => Icons.rice_bowl,
        'soup' => Icons.soup_kitchen,
        'meat' => Icons.restaurant,
        'salad' => Icons.eco,
        'snack' => Icons.bakery_dining,
        'drink' => Icons.local_cafe,
        _ => Icons.fastfood,
      };

  static Color _hex(String h) => Color(int.parse(h.replaceFirst('#', '0xFF')));
}

/// Kategori beserta ikonnya (dipakai di beranda & filter).
const Map<String, IconData> kCategories = {
  'Makanan Berat': Icons.rice_bowl,
  'Sup': Icons.soup_kitchen,
  'Camilan': Icons.bakery_dining,
  'Minuman': Icons.local_cafe,
};
