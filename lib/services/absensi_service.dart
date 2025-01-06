import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

class AttendanceService {
  String baseUrl = "http://127.0.0.1:8000/";

  final box = GetStorage();

  Map<String, String> get _headers {
    String token = box.read('usertoken');
    return {
      'Authorization': token,
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, dynamic>> checkIn({
    required String userId,
    required File photo,
  }) async {
    try {
      // Get current location
      final position = await _getCurrentLocation();

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/attendance/checkin'),
      );

      // Add authorization header
      request.headers.addAll({
        'Authorization': box.read('usertoken'),
      });

      // Add fields
      request.fields.addAll({
        'userId': userId,
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
        'checkInTime': DateTime.now().toIso8601String(),
      });

      // Add photo
      var photoStream = http.ByteStream(photo.openRead());
      var length = await photo.length();
      var multipartFile = http.MultipartFile(
        'photo',
        photoStream,
        length,
        filename: 'checkin_photo.jpg',
      );
      request.files.add(multipartFile);

      // Send request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseData);
      } else {
        throw Exception('Failed to check in: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Check-in failed: $e');
    }
  }

  Future<Map<String, dynamic>> checkOut({
    required String userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/attendance/checkout'),
        headers: _headers,
        body: json.encode({
          'userId': userId,
          'checkOutTime': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to check out: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Check-out failed: $e');
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
