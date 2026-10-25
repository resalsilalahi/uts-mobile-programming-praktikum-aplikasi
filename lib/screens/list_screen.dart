import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';
import '../widgets/recipe_card.dart';
import 'detail_screen.dart';

/// Halaman 2 - Daftar Resep: pencarian + filter kategori.
/// Dipakai sebagai tab (showBack=false) maupun halaman hasil navigasi push.
class ListScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final String? initialCategory;
  final String initialQuery;
  final bool showBack;

  const ListScreen({
    super.key,
    required this.recipes,
    this.initialCategory,
    this.initialQuery = '',
    this.showBack = true,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late String? _category = widget.initialCategory;
  late final _controller = TextEditingController(text: widget.initialQuery);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _controller.text.toLowerCase();
    final items = widget.recipes.where((r) {
      final okCat = _category == null || r.category == _category;
      final okQuery = r.name.toLowerCase().contains(q);
      return okCat && okQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBack,
        title: Text(_category ?? 'Daftar Resep'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: TextField(
                  controller: _controller,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Cari nama resep...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _chip('Semua', null),
                    ...kCategories.keys.map((c) => _chip(c, c)),
                  ],
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text('Resep tidak ditemukan'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        itemBuilder: (_, i) => RecipeCard(
                          recipe: items[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailScreen(recipe: items[i])),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, String? value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: ChoiceChip(
          label: Text(label),
          selected: _category == value,
          selectedColor: AppColors.accent,
          onSelected: (_) => setState(() => _category = value),
        ),
      );
}
