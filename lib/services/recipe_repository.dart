import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';

/// Sumber data resep.
///
/// Saat ini membaca file JSON lokal (data dummy). Pada tahap berikutnya,
/// cukup ganti isi [fetchRecipes] dengan permintaan HTTP, misalnya:
///   final res = await http.get(Uri.parse('https://api.example.com/recipes'));
///   final data = jsonDecode(res.body);
/// Bentuk JSON dan model [Recipe] tidak perlu diubah.
class RecipeRepository {
  Future<List<Recipe>> fetchRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    return (data['recipes'] as List)
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
