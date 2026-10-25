import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_repository.dart';
import '../theme.dart';
import 'home_screen.dart';
import 'list_screen.dart';

/// Kerangka utama: memuat data sekali, lalu menampilkan
/// NavigationBar (Beranda & Daftar Resep).
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final _repo = RecipeRepository();
  late final Future<List<Recipe>> _future = _repo.fetchRecipes();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snap.hasError) {
          return Scaffold(body: Center(child: Text('Gagal memuat data: ${snap.error}')));
        }
        final recipes = snap.data!;
        return Scaffold(
          body: IndexedStack(index: _index, children: [
            HomeScreen(recipes: recipes),
            ListScreen(recipes: recipes, showBack: false),
          ]),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: AppColors.accent.withAlpha(120),
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
              NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Resep'),
            ],
          ),
        );
      },
    );
  }
}
