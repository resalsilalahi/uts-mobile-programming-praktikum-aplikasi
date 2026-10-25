import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';

/// Halaman 3 - Detail resep: bahan, langkah, info waktu & tingkat kesulitan.
class DetailScreen extends StatefulWidget {
  final Recipe recipe;
  const DetailScreen({super.key, required this.recipe});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: r.color,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(_fav ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  setState(() => _fav = !_fav);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text(_fav ? 'Ditambahkan ke favorit' : 'Dihapus dari favorit'),
                  ));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(r.name, style: const TextStyle(fontSize: 16)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [r.color, AppColors.dark],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Center(child: Icon(r.iconData, size: 90, color: Colors.white54)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _info(Icons.timer, '${r.timeMinutes} mnt', 'Waktu'),
                          _info(Icons.speed, r.difficulty, 'Kesulitan'),
                          _info(Icons.star, r.rating.toString(), 'Rating'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(r.description, style: const TextStyle(height: 1.5)),
                      const SizedBox(height: 20),
                      _section('Bahan-bahan'),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: r.ingredients
                                .map((e) => ListTile(
                                      dense: true,
                                      leading: const Icon(Icons.check_circle,
                                          color: AppColors.primary, size: 20),
                                      title: Text(e),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _section('Langkah Memasak'),
                      ...List.generate(
                        r.steps.length,
                        (i) => Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.primary,
                              child: Text('${i + 1}',
                                  style: const TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                            title: Text(r.steps[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      );

  Widget _info(IconData i, String v, String l) => Column(children: [
        Icon(i, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(v, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(l, style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
      ]);
}
