# Flutter Attendance App

Aplikasi presensi mobile yang dibangun menggunakan Flutter dengan fitur check-in (foto dan lokasi) dan check-out.

## Persyaratan Sistem

- Flutter SDK (latest version)
- Dart SDK (latest version)
- PHP >= 8.0
- Composer
- Git
- Android Studio / VS Code
- Android Emulator / Physical Device

## Langkah-langkah Instalasi

### 1. Setup Backend (Laravel)

1. Clone repository API Laravel:

```bash
git clone https://github.com/alzahfariski/laravel-absensi-api.git
cd laravel-absensi-api
```

2. Install dependencies Laravel:

```bash
composer install
```

3. Buat file .env:

```bash
cp .env.example .env
```

4. Generate application key:

```bash
php artisan key:generate
```

5. Setup database di file .env:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nama_database
DB_USERNAME=username_database
DB_PASSWORD=password_database
```

6. Jalankan migration:

```bash
php artisan migrate
```

7. Jalankan server Laravel:

```bash
php artisan serve
```

Server akan berjalan di `http://127.0.0.1:8000`

### 2. Setup Flutter App

1. Clone repository Flutter app (jika menggunakan git):

```bash
git clone [url-repository-flutter-anda]
cd [nama-folder-project]
```

2. Install dependencies Flutter:

```bash
flutter pub get
```

3. Buka file `lib/services/attendance_service.dart` dan ubah baseUrl sesuai dengan server Laravel:

```dart
final attendanceService = AttendanceService(
  baseUrl: 'http://10.0.2.2:8000/api'  // Untuk Android Emulator
  // atau
  // baseUrl: 'http://192.168.1.x:8000/api'  // Untuk Physical Device (ganti x dengan IP local Anda)
);
```

4. Jalankan aplikasi:

```bash
flutter run
```

## Konfigurasi Tambahan

### Android

Tambahkan permission berikut di `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
    <!-- Internet Permission -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <!-- Location Permission -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <!-- Camera Permission -->
    <uses-permission android:name="android.permission.CAMERA" />
    ...
</manifest>
```

### iOS

Tambahkan konfigurasi berikut di `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Camera Permission -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access for taking check-in photos</string>

    <!-- Location Permission -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs access to location for attendance check-in</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>This app needs access to location for attendance check-in</string>
    ...
</dict>
```

## Struktur Project

```
lib/
  ├── screens/
  │   └── absensi_screen.dart
  │   └── login_screen.dart
  ├── services/
  │   └── attendance_service.dart
  │   └── auth_service.dart
  ├── utils/
  │   └── constants/
  │       └── color.dart
  └── main.dart
```

## Dependencies

Tambahkan dependencies berikut di `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  geolocator: ^10.0.0
  image_picker: ^1.0.0
  get_storage: ^2.1.1
  d_info: ^0.2.0
  ming_cute_icons: ^0.0.3
  one_clock: ^1.0.9
```

## Troubleshooting

1. Error "Connection refused":

   - Pastikan server Laravel sedang berjalan
   - Periksa baseUrl yang digunakan
   - Jika menggunakan physical device, pastikan device dan komputer berada dalam jaringan yang sama

2. Error "Permission denied":

   - Pastikan semua permission sudah ditambahkan di AndroidManifest.xml dan Info.plist
   - Berikan izin aplikasi melalui pengaturan device

3. Error "Platform Exception":
   - Pastikan semua plugin sudah diinstal dengan benar
   - Jalankan `flutter clean` dan `flutter pub get`

## API Endpoints

Backend Laravel menyediakan endpoint berikut:

- POST `/api/attendance/checkin` - Untuk melakukan check-in
- POST `/api/attendance/checkout` - Untuk melakukan check-out

## Kontribusi

Silakan buat pull request untuk berkontribusi pada project ini.

## License

[MIT License](LICENSE)
