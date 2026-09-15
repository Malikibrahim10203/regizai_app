# 🥗 RegizAI - Sistem Rekomendasi Gizi Seimbang Berbasis AI

<p align="center">
  <img src="https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800" alt="RegizAI Banner" width="100%" style="border-radius: 16px; max-height: 280px; object-fit: cover;" />
</p>

<p align="center">
  <b>Aplikasi Mobile Android Cerdas untuk Pemantauan Pola Makan & Rekomendasi Nutrisi Harian</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-10B981?style=for-the-badge" alt="Clean Architecture" />
  <img src="https://img.shields.io/badge/State%20Management-BLoC%20%2F%20Cubit-8B5CF6?style=for-the-badge" alt="BLoC" />
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
</p>

---

## 📌 Tentang Proyek

**RegizAI** (*Sistem Rekomendasi Gizi Seimbang Berbasis AI* - Dokumen No: `GL02.02-SRS-00`) adalah aplikasi kesehatan modern yang dirancang untuk membantu masyarakat Indonesia memantau asupan nutrisi harian, menjaga berat badan ideal, dan menerapkan pedoman gizi seimbang (*Isi Piringku*) sesuai anjuran Kementerian Kesehatan RI.

Aplikasi ini dibangun menggunakan arsitektur **Clean Architecture (Uncle Bob)** dan state management **BLoC (`flutter_bloc`)**, serta dilengkapi dengan layer offline mock dan persistensi lokal sehingga dapat diuji dan dijalankan secara penuh tanpa ketergantungan server eksternal.

---

## ✨ Fitur Unggulan

| Fitur | Deskripsi |
| :--- | :--- |
| 🔍 **AI Food Scanner** | Simulasi deteksi visual makanan berbasis visi komputer untuk menganalisis taksiran kalori dan makronutrien piring makanan secara instan. |
| 📊 **Health & Calorie Dashboard** | Memantau batas target kalori harian, sisa kebutuhan kalori, serta rasio konsumsi makronutrien (Karbohidrat, Protein, dan Lemak). |
| 📖 **Katalog Makanan Sehat** | Direktori makanan sehat lokal Indonesia lengkap dengan profil nutrisi, takaran porsi, dan filter kategori. |
| ⚖️ **Kalkulator IMT / BMI** | Penghitungan Indeks Massa Tubuh akurat dengan klasifikasi status gizi standar WHO/Kemenkes beserta saran ahli gizi. |
| 📝 **Catatan Konsumsi Harian** | Riwayat log makanan harian dengan sistem penyimpanan lokal (*offline persistence*) berbasis `SharedPreferences`. |
| 📰 **Artikel Edukasi Gizi** | Bacaan dan tips pola hidup sehat seputar hidrasi, sarapan seimbang, dan tips pencegahan penyakit metabolik. |
| 👤 **Profil & Data Fisik** | Pengelolaan data pengguna (usia, berat badan, tinggi badan, jenis kelamin) untuk kalkulasi gizi yang dipersonalisasi. |

---

## 🏛️ Arsitektur Sistem: Clean Architecture

Proyek ini menerapkan pemisahan tanggung jawab yang ketat (*Separation of Concerns*) dengan format direktori:

```
lib/
├── app/
│   └── config/                    # Konfigurasi global aplikasi
│       ├── app_config.dart        # Environment config (dev/staging/prod)
│       ├── routes/
│       │   └── app_routes.dart    # Definisi named routing aplikasi
│       └── app.dart               # Root widget, MultiBlocProvider & MaterialApp
│
├── core/                          # Komponen reusable lintas fitur
│   ├── constants/
│   │   └── app_constants.dart     # Konstanta global (storage keys, targets, dll)
│   ├── di/
│   │   └── injection_container.dart # Dependency Injection (GetIt setup)
│   ├── errors/
│   │   ├── exceptions.dart        # Definisi Exception
│   │   └── failures.dart          # Definisi Failure
│   ├── theme/
│   │   └── app_theme.dart         # ThemeData, warna, typography, card styling
│   ├── usecase/
│   │   └── usecase.dart           # Base UseCase contract
│   └── utils/
│       ├── date_formatter.dart    # Format tanggal & waktu lokal Indonesia
│       └── input_validators.dart  # Helper validasi form
│
└── features/                      # Modul fitur yang berdiri sendiri (Modular)
    ├── auth/                      # Fitur Autentikasi & Profil Pengguna
    │   ├── data/ (datasources, models, repositories)
    │   ├── domain/ (entities, repositories, usecases)
    │   └── presentation/ (bloc, pages, widgets)
    ├── journal/                   # Fitur Dashboard & Catatan Konsumsi
    │   ├── data/ (datasources, models, repositories)
    │   ├── domain/ (entities, repositories, usecases)
    │   └── presentation/ (bloc, pages, widgets)
    ├── food_catalog/              # Fitur Katalog Makanan Sehat
    │   ├── data/ (datasources, models, repositories)
    │   ├── domain/ (entities, repositories, usecases)
    │   └── presentation/ (cubit, pages, widgets)
    ├── ai_scanner/                # Fitur Scanner Makanan AI
    │   ├── data/ (datasources, models, repositories)
    │   ├── domain/ (entities, repositories, usecases)
    │   └── presentation/ (bloc, pages, widgets)
    ├── bmi/                       # Fitur Kalkulator IMT & Rekomendasi
    │   ├── domain/ (entities, usecases)
    │   └── presentation/ (cubit, pages, widgets)
    └── articles/                  # Fitur Edukasi & Artikel Gizi
        ├── domain/ (entities, usecases)
        └── presentation/ (cubit, pages, widgets)
```

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK >= 3.0.0)
- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) `^9.1.1` & [`equatable`](https://pub.dev/packages/equatable) `^2.1.0`
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it) `^9.2.1`
- **Local Storage**: [`shared_preferences`](https://pub.dev/packages/shared_preferences) `^2.2.3`
- **UI & Iconography**: Material 3, Custom Glassmorphism Theme Tokens, Cupertino Icons, Font Awesome

---

## 🚀 Panduan Menjalankan Aplikasi

### 1. Prasyarat
Pastikan lingkungan pengembangan Anda telah terpasang:
- Flutter SDK (versi 3.24 atau lebih baru direkomendasikan)
- Android Studio / VS Code dengan ekstensi Flutter & Dart
- Android Device atau Emulator (Android 8.0 / API level 26+)

### 2. Kloning Repositori
```bash
git clone https://github.com/neusid/regizai_app.git
cd regizai_app
```

### 3. Pasang Dependensi
```bash
flutter pub get
```

### 4. Jalankan Analisis & Pengujian
```bash
# Static analysis (Harus 0 error)
flutter analyze

# Unit & Widget tests
flutter test
```

### 5. Jalankan Aplikasi
```bash
flutter run
```

---

## 🌿 Manajemen Branch Git

- **`main`**: Branch produksi aktif yang mengimplementasikan Clean Architecture & BLoC state management.
- **`backup/main`**: Branch cadangan snapshot kondisi kode awal sebelum perombakan.
- **`feature/clean-architecture-bloc`**: Branch fitur tempat pengembangan Clean Architecture & BLoC dilakukan.

---

<p align="center">
  Dibuat dengan ❤️ untuk masyarakat Indonesia yang lebih sehat dan berdaya gizi seimbang.
</p>
