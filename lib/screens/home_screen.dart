import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';
import '../widgets/recipe_card.dart';
import 'detail_screen.dart';
import 'list_screen.dart';

/// Halaman 1 - Beranda: sapaan, pencarian, kategori, resep populer & terbaru.
class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  const HomeScreen({super.key, required this.recipes});

  void _openList(BuildContext c, {String? category, String query = ''}) {
    Navigator.push(c, MaterialPageRoute(
      builder: (_) => ListScreen(recipes: recipes, initialCategory: category, initialQuery: query),
    ));
  }

  void _openDetail(BuildContext c, Recipe r) =>
      Navigator.push(c, MaterialPageRoute(builder: (_) => DetailScreen(recipe: r)));

  @override
  Widget build(BuildContext context) {
    final popular = recipes.where((r) => r.rating >= 4.7).toList();
    final latest = recipes.reversed.take(4).toList();

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _header(context),
              const SizedBox(height: 16),
              _categories(context),
              _title('Resep Populer'),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: popular.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _popularCard(context, popular[i]),
                ),
              ),
              _title('Resep Terbaru'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: latest
                      .map((r) => RecipeCard(recipe: r, onTap: () => _openDetail(context, r)))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        decoration: const BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selamat Datang',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Mau masak apa hari ini?',
                style: TextStyle(color: Colors.white.withAlpha(170))),
            const SizedBox(height: 16),
            TextField(
              onSubmitted: (v) => _openList(context, query: v),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Cari resep...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      );

  Widget _categories(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: kCategories.entries.map((e) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _openList(context, category: e.key),
              child: SizedBox(
                width: 76,
                child: Column(children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(220),
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(e.value, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(e.key,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
            );
          }).toList(),
        ),
      );

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 22, 16, 10),
        child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      );

  Widget _popularCard(BuildContext context, Recipe r) => GestureDetector(
        onTap: () => _openDetail(context, r),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [r.color, r.color.withAlpha(170)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(r.iconData, color: Colors.white, size: 40),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(r.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  Text(' ${r.rating}  •  ${r.timeMinutes} menit',
                      style: const TextStyle(color: Colors.white, fontSize: 12)),
                ]),
              ]),
            ],
          ),
        ),
      );
}
