# Howgorithms

**Howgorithms** adalah aplikasi mobile (Flutter) yang menyediakan **visualisasi** dan **pemahaman mendalam** mengenai berbagai algoritma klasik, seperti **Bubble Sort**, **Merge Sort**, **Binary Search**, dan **Classical Search**. Selain itu, aplikasi ini juga dilengkapi dengan **kuis interaktif** untuk menguji pemahaman pengguna terhadap setiap algoritma.

---

## Fitur Utama

1. **Visualisasi Langkah per Langkah**  
   - Pengguna dapat memasukkan **array** atau **data** lain yang diperlukan, lalu melihat proses algoritma **langkah per langkah**.  
   - Tampilan akan menyorot elemen yang sedang diproses (misalnya, indeks yang dibandingkan, elemen yang diswap, dsb.).  

2. **Kuis Interaktif**  
   - Tersedia kuis untuk setiap algoritma (contoh: "Haruskah swap?" pada Bubble Sort, atau "Pergi Left atau Right?" pada Binary Search).  
   - Pengguna akan mendapat **+1 poin** untuk jawaban benar dan **-1 poin** untuk jawaban salah.  
   - Skor pengguna akan disimpan di **database** (menggunakan [Supabase](https://supabase.com/)).

3. **Profil & Skor**  
   - Pengguna dapat melihat profil mereka, termasuk **email** dan **score** masing-masing algoritma serta total score dan ranking.  
   - Tersedia tombol **Sign out** untuk keluar dari akun.

4. **Tampilan Home & Algoritma**  
   - **Home Screen** menghadirkan animasi Lottie dan teks animasi (via `animated_text_kit`) untuk memperkenalkan Howgorithms secara ringkas dan menarik.  
   - **Algorithms Screen** menampilkan daftar algoritma (Bubble Sort, Merge Sort, Binary Search, dsb.) yang tersedia untuk dipelajari, disertai kartu informasi dan link ke halaman masing-masing algoritma.

---

## Struktur Direktori (Contoh)

```bash
lib/
├─ auth/
│   └─ auth_service.dart            # Layanan otentikasi Supabase
├─ database/
│   └─ progress_database.dart       # Streaming data skor (progress)
├─ models/
│   └─ progress.dart                # Model untuk data progress & skor
├─ router/
│   └─ routes.dart                  # Definisi GoRouter routes
├─ screens/
│   ├─ home_screen.dart             # Layar utama dengan animasi
│   ├─ algorithms_screen.dart       # Daftar algoritma
│   ├─ bubble_sort_screen.dart      # Visualisasi & input Bubble Sort
│   ├─ merge_sort_screen.dart       # Visualisasi Merge Sort
│   ├─ binary_search_screen.dart    # Visualisasi Binary Search
│   ├─ classical_search_screen.dart # Visualisasi Classical (Linear) Search
│   └─ profile_screen.dart          # Profil pengguna (score, sign out)
├─ widgets/
│   ├─ algorithm_app_bar.dart       # AppBar kustom
│   ├─ algorithm_card.dart          # Widget kartu untuk algoritma
│   ├─ algorithm_visualization.dart # Widget umum untuk menampilkan snapshot
│   └─ ...widget lain...
└─ main.dart                        # Entry point aplikasi Flutter
```

---

## Cara Menjalankan Aplikasi

1. **Clone** repositori ini (atau unduh zip-nya).
2. Pastikan Anda memiliki **Flutter SDK** dan **Dart** yang terinstal.  
3. Jalankan perintah berikut di root folder proyek:
   ```bash
   flutter pub get
   flutter run
   ```
4. Aplikasi akan berjalan di emulator/simulator atau device fisik yang terhubung.

> **Catatan**: Pastikan Anda sudah mengkonfigurasi **Supabase** (URL dan `anonKey`) di `lib/auth/auth_service.dart` atau di file `.env` sesuai kebutuhan.

---

## Konfigurasi Supabase

1. Buat project di [**Supabase**](https://supabase.com/).  
2. Dapatkan URL proyek dan `anonKey` Anda.  
3. Di dalam `auth_service.dart` (atau file konfigurasi lain), sesuaikan inisialisasi client:
   ```dart
   final supabase = SupabaseClient(
     'YOUR_SUPABASE_URL',
     'YOUR_SUPABASE_ANON_KEY',
   );
   ```
4. Pastikan tabel dan kolom yang dibutuhkan (misalnya `progress` dengan kolom `bubble_score`, `merge_score`, dsb.) telah dibuat di dashboard Supabase.

---

## Teknologi yang Digunakan

- **Flutter** (Dart)  
- **Supabase** (untuk otentikasi & database)  
- **GoRouter** (untuk navigasi)  
- **animated_text_kit** (animasi teks di HomeScreen)  
- **lottie** (animasi Lottie di HomeScreen)  

---

## Contributing

1. **Fork** repositori ini.  
2. **Buat branch** baru untuk fitur/penyesuaian yang akan Anda kembangkan.  
3. **Commit** dan **push** perubahan Anda.  
4. Buat **pull request** ke branch utama (jika repositori ini dikelola publik).  

---

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE). Anda bebas memodifikasi, menyebarluaskan, dan menggunakannya untuk tujuan apa pun.  

---

**Selamat belajar dan bereksplorasi dengan Howgorithms!**  
Jika Anda memiliki pertanyaan atau saran, jangan ragu untuk membuat _issue_ atau berkontribusi langsung.

