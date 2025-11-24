# 🏨 Flutter Hotel CRUD App

Aplikasi **CRUD Hotel** berbasis Flutter yang terhubung dengan backend API.  
Project ini digunakan untuk menampilkan, menambah, mengedit, dan menghapus data hotel.

Flutter dipilih karena cepat, multiplatform, dan mudah dikembangkan.

---

## 🚀 Fitur Aplikasi
- Menampilkan list hotel
- Detail hotel
- Tambah data hotel
- Edit data hotel
- Hapus hotel
- UI responsif menggunakan Flutter widgets

---

# 📱 Teknologi yang Digunakan
- **Flutter 3.x**
- **Dart**
- **HTTP Package**
- **State Management:** Provider / GetX / Bloc *(sesuaikan)*  
- **REST API**: JSON-based

---

# 📥 Instalasi Project

## 1️⃣ Clone Repository
```bash
git clone https://github.com/USERNAME/NAMA-REPO.git
cd NAMA-REPO
```

---

## 2️⃣ Install Dependencies
Jalankan:

```bash
flutter pub get
```

---

## 3️⃣ Konfigurasi API Endpoint
Buka file berikut:

```
lib/config/api.dart
```

Atur URL backend:

```dart
const String baseUrl = "http://127.0.0.1:8000/api";
```

Jika memakai emulator Android, gunakan:

```dart
const String baseUrl = "http://10.0.2.2:8000/api";
```

---

## 4️⃣ Menjalankan Aplikasi

### **Android**
```
flutter run
```

### **Web**
```
flutter run -d chrome
```

### **iOS** *(hanya MacOS)*
```
flutter run -d ios
```

---

# 📦 Struktur Folder
```
/lib
│── main.dart
│── models/
│── pages/
│── services/
│── widgets/
│── config/
│
└── README.md
```

---

# 🧪 Testing

```
flutter test
```

---

# 🛠️ Build Release

### Android (APK)
```
flutter build apk --release
```

### Web
```
flutter build web
```

---

# 🔗 Integrasi Backend

Pastikan backend API menyediakan endpoint:

| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | /hotels | List hotel |
| POST | /hotels | Tambah hotel |
| GET | /hotels/{id} | Detail hotel |
| PUT/PATCH | /hotels/{id} | Edit hotel |
| DELETE | /hotels/{id} | Hapus |

---

# ❗ Troubleshooting

### Flutter tidak jalan?
- Pastikan Flutter SDK sudah dipasang
- Cek device:
  ```
  flutter devices
  ```
- Cek environment:
  ```
  flutter doctor
  ```

### Tidak bisa konek API?
- Gunakan `10.0.2.2` untuk Android emulator
- Pastikan backend berjalan (`php artisan serve`)
- Pastikan CORS di backend sudah aktif

---

# 📄 Lisensi
Project ini bisa menggunakan MIT License atau lisensi lain sesuai kebutuhan.

---

# 🤝 Kontribusi
Pull request dan issue sangat diterima untuk pengembangan lebih lanjut.

