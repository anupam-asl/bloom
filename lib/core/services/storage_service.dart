import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';

class StorageService {
  static const _key = 'bloom_session';
  static final _storage = FlutterSecureStorage();

  static Future<void> saveSession(Session session) async {
    await _storage.write(key: _key, value: jsonEncode(session.toJson()));
  }

  static Future<Session?> loadSession() async {
    final data = await _storage.read(key: _key);
    if (data == null) return null;
    return Session.fromJson(jsonDecode(data));
  }

  static Future<void> clearSession() async {
    await _storage.delete(key: _key);
  }
}
