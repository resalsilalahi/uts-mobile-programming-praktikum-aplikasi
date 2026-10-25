# Resep Nusantara

Aplikasi mobile Flutter untuk menjelajahi resep masakan Indonesia.
Dibuat untuk UTS Mobile Programming (Semester Ganjil 2025/2026).

## Tema & Tujuan
Membantu pengguna menemukan resep masakan Nusantara berdasarkan kategori
(Makanan Berat, Sup, Camilan, Minuman) lengkap dengan bahan dan langkah memasak.

## Halaman
| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Sapaan, pencarian, kategori, resep populer & terbaru |
| Daftar Resep | `lib/screens/list_screen.dart` | Daftar semua resep, pencarian, filter kategori |
| Detail Resep | `lib/screens/detail_screen.dart` | Bahan, langkah, waktu, kesulitan, rating, tombol favorit |

Navigasi: `BottomNavigationBar` (Beranda <-> Resep) dan `Navigator.push` (ke daftar/detail).

## Struktur Proyek
```
lib/
  main.dart
  theme.dart
  models/recipe.dart
  services/recipe_repository.dart   # sumber data (JSON lokal -> API nanti)
  screens/ (main_shell, home, list, detail)
  widgets/recipe_card.dart
assets/data/recipes.json            # data dummy
```

## Persiapan API
Seluruh data diambil lewat `RecipeRepository.fetchRecipes()`. Untuk beralih ke
API, ganti isinya dengan request HTTP (paket `http`); model `Recipe.fromJson`
sudah sesuai dengan struktur JSON.

## Cara Menjalankan
```bash
flutter create .      # sekali saja, untuk membuat folder android/ios
flutter pub get
flutter run
```
Pastikan Flutter SDK >= 3.10 (Dart 3).
